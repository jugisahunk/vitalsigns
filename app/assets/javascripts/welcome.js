$(function(){
    function create_pr_stats_chart(){
        jQuery.getJSON(
            "/pr_stats/get_pr_lifetimes",
            null,
            on_get_pr_lifetimes_success
        );
    }

    function on_get_pr_lifetimes_success(pr_lifetimes){
        var chart_data = [];
        for(var i=0; i < pr_lifetimes.length; i++){
            chart_data.push({
                x : pr_lifetimes[i].merged_at,
                y : pr_lifetimes[i].life_time
            });
        }

        var context = $("#pr_line");
        var pr_line_chart = new Chart(context, {
            type: 'line',
            data: {
                datasets: [{
                    label: 'Lifetime',
                    data: chart_data
                }]
            },
            options: {
                    scales: {
                        xAxes: [{
                            type: "time"
                        }]
                    }
                }
        });
    }

    function show_chart_stats(){
        jQuery.getJSON(
            "/pr_stats/get_pr_stats",
            null,
            on_get_pr_stats_success
        );        
    }

    function on_get_pr_stats_success(pr_stats_data){
        $("#mean").text("Mean: " + pr_stats_data.mean);
        $("#median").text("Median: " + pr_stats_data.median);
        $("#mean1").text("Mean level 1: " + pr_stats_data.lev1_mean);
        $("#mean2").text("Mean level 2: " + pr_stats_data.lev2_mean);
        $("#mean3").text("Mean level 3: " + pr_stats_data.lev3_mean);
    }

    create_pr_stats_chart();
    show_chart_stats();
})

