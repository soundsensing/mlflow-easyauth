
import mlflow

def main():

    mlflow.set_tag('test', 'true')
    mlflow.log_param('param1', 100)
    mlflow.log_metric('metricA', 10)


if __name__ == '__main__':
    main()
