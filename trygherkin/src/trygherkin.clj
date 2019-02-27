(ns trygherkin
  (:require [clojure.string :as str]
            [clj-time.core :as t]
            [clj-http.client :as client]
            [scenari.core :refer :all]))

(defwhen #"I create a new product with name '(.*)' and description '(.*)'"
  [_ name desc]
  (println "executing my product creation function with params " name desc)
  (let [id "42"]
        {:id id
         :name name
         :desc desc
         :qty (rand-int 50)
         :location-url (str "http://example.com/product/" id)}))

(defthen #"I receive a response with an id ([0-9]+) and a location URL"
  [product id]
  (let [url (:location-url product)]
    (assert (= id (:id product)))
    (assert (str/starts-with? url "http://"))
    [id url]))

(defwhen #"When I invoke a GET request on location URL"
  [_]
  (let [response (client/get "http://example.com/")]
    (assert (= 200 (:status response)))
    response))

(defthen #"I receive a ([0-9]+) response"
  [response expected]
  (let [http-status (:status response)]
    (assert (str "the status of the HTTP response should be " expected " but was " http-status)
            (= (str expected) http-status))
    (:status response)))

(defn -main []
  (println "Hello world, the time is" (t/now))
  (exec-spec "src/test.feature"))
