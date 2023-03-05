
import mlflow

def main():

    with mlflow.start_run():

        mlflow.set_tag('test', 'true')
        mlflow.log_param('param1', 100)
        mlflow.log_metric('metricA', 10)

        features = "rooms, zipcode, median_price, school_rating, transport"
        artifact_path = "features.txt" 
        with open(artifact_path, "w") as f:
            f.write(features)

        mlflow.log_artifact(artifact_path)

if __name__ == '__main__':
    main()
