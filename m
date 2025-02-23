Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E02BAF7;
	Sun, 23 Feb 2025 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740295184; cv=none; b=ejrSoliO2yTCF9ILQEZMrBi+KdNnksRuWmrH3Bt/xq8AAqd9Xup4lr9QDnsDc2Z6b23w8ADT+MlCoUFJLauf2ZHhO9pIygPlBPhQ2h8AdsvHxZweLBIsFVFswtpYotleWVsuAlFO69YnMEU2o+mQxhrBgvuDvpF754N4iSD5hOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740295184; c=relaxed/simple;
	bh=3s//kK1v5HwrGxA4bxbPTKrcj8IMbSIhu0XLaPZ8Qro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPOzUDIiZ2ZqLivlkaYMcS0scLUBcqvvhwjnXgPldlk9VbNwppduG2PPfSsNYilh2P2k3PnjiDVTTO0ixmCTRsMl3p1NCW4pVAEDP/e96b7dMoVVqjouR608vgeg7OtHVrl34rLdkag4NOwMpFVVRaDFwpRFMmw7hFX6TNfuYcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CT/8dlH4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CT/8dlH4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N3K4RL027970;
	Sun, 23 Feb 2025 07:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dij0yI
	Yzj4zL8CNIMdW5A046jovSl4+qz20bZoGhC8M=; b=CT/8dlH4Z2r3fDdhgg40PQ
	D2n0qHlz+RVESvzoW4ovZvXrA0HKakRbc3zQQsdxeYNLCUYJOqGO9ZrG7sQGoXD5
	1nrR63sH0fZrn0XTh2H8d5mGvltZ6KyO9oO51KFGDj0fIz/33PSSP5lf6lirAeeX
	E8B45GUStlU72sTzSg+zZBv2DLiDWGe7s8TOet9uFXC3RyPDymOF55+rx1kxEazv
	6FP//DrSnEPpz6AwiV/s/LMPcxgxdcQbl92btgaTaEGvuI3KH2P4+gQQDgZO9uIi
	5l5ok4M21iYGB/yoJmT0o5YmatAndr7FXDWtGqnPCwQTc1XxIAyyUCL2JWe0M4sw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ysr9rw2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 07:19:18 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51N7JI3C011010;
	Sun, 23 Feb 2025 07:19:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ysr9rw2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 07:19:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N4vCvS012597;
	Sun, 23 Feb 2025 07:19:16 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9y1byp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 07:19:16 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N7JG3a24052284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 07:19:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 316FF58055;
	Sun, 23 Feb 2025 07:19:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C3DC58043;
	Sun, 23 Feb 2025 07:19:11 +0000 (GMT)
Received: from [9.43.34.198] (unknown [9.43.34.198])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 07:19:10 +0000 (GMT)
Message-ID: <3eaea922-0c78-414b-9609-abda0c97a13a@linux.ibm.com>
Date: Sun, 23 Feb 2025 12:49:09 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/topology: replace kzalloc() with kcalloc() in
 sched_init_numa()
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250222-sched-kcalloc-v1-1-4dee15fd8241@ethancedwards.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250222-sched-kcalloc-v1-1-4dee15fd8241@ethancedwards.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hHOPWLPOYiaij2BIl7zKRnHgDr42fKQe
X-Proofpoint-GUID: 1qsb0fS9nhYsqnZlMJuPL_Eq6iwjelU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_02,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502230052

Hi Ethan,

On 23/02/25 01:16, Ethan Carter Edwards wrote:
> We are trying to get rid of all multiplications from allocation
> functions to prevent integer overflows[1]. Here the multiplication is
> obviously safe, but using kcalloc() is more appropriate and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  kernel/sched/topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index c49aea8c10254dec985bba47b18f61be954d23f6..b4539b29fb36f6b2f0c5ca310620ebda29755e5c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1918,7 +1918,7 @@ void sched_init_numa(int offline_node)
>  	 */
>  	sched_domains_numa_levels = 0;
>  
> -	masks = kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
> +	masks = kcalloc(nr_levels, sizeof(void *), GFP_KERNEL);

Even though an overflow is very unlikely here, using kcalloc() improves
readability and adds a safeguard since its built-in overflow check has
minimal overhead.

Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks,
Madadi Vineeth Reddy

>  	if (!masks)
>  		return;
>  
> @@ -1927,7 +1927,7 @@ void sched_init_numa(int offline_node)
>  	 * CPUs of nodes that are that many hops away from us.
>  	 */
>  	for (i = 0; i < nr_levels; i++) {
> -		masks[i] = kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
> +		masks[i] = kcalloc(nr_node_ids, sizeof(void *), GFP_KERNEL);
>  		if (!masks[i])
>  			return;
>  
> 
> ---
> base-commit: 5cf80612d3f72c46ad53ef5042b4c609c393122f
> change-id: 20250222-sched-kcalloc-1d5acea7249b
> 
> Best regards,

