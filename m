Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C843DEAD1
	for <linux-hardening@vger.kernel.org>; Thu, 16 Apr 2026 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349611; cv=none; b=BnTr3qpLwkmenR2vdqbK4Evnu17V0NvDGlZynDJFYuBSLn0dGkUmG78Atc1gAdilVBz6KNcW8zkFOlsjuSuaGidU6FmnM+orBhvzBOz4qrYu00fA3iftihhqhDeZS+mhcspnMktF41k1jA4zk7UAujDhrunudhnc/NOK7Q+t3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349611; c=relaxed/simple;
	bh=+ihRt159uDvL5POKuTFYrUQrN+nOHKn/wmFeBTjQ8PU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=rH7b7AMhxbCkrWl3wcpq6EtHS61KKcf7JlBjLbjVFAfZpPYFiLayW2ApuQCk0nHUPbg9drq0k8iVFOH8Qo8SEIQX9209+xBbCbAcPGEliljIMS2fzWQnTZUkUDTPnvpFXjt5EsRHBeN3oaoI6vEIpG4J3Zgzj6h1amcQZFqCIbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=D2eODzek; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="D2eODzek"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so7275003eec.1
        for <linux-hardening@vger.kernel.org>; Thu, 16 Apr 2026 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1776349609; x=1776954409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8v+obRShzSvZ2yzdjqq0ScZzC9F5RXeUMbtvLHvstk=;
        b=D2eODzek1m1dEqfD7qSAVgbyTV+MyOeLxa5HQR5esESnXiSr3tAPBRP+1pXqxcNBwy
         WmUQaxK4XbLTDtJP75r7ctiHgPlDfX1ZnHTWKfD27gQ3rAOAXl7TC51koVwj1kkDEw/B
         Qvip0lt6QQdRh5ro09uoMppnelNjmG8e+iebEkp5k8LsVGgbiS2lcp48szOyc/9BBgm2
         ZH4+Yn/9D1L9/mgaGa3CBq+gEHd2+ww7WpvrPeskR7sq3wQZD/nBKh4MxX1nq+znKE+C
         1as70PB0roi4Cfv1FHvrjKt9LXzHflGHKmJqOcKmgH6ThvnYuQPQkGo1ipKdkEtWKyBQ
         sLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349609; x=1776954409;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8v+obRShzSvZ2yzdjqq0ScZzC9F5RXeUMbtvLHvstk=;
        b=rpCGPr4xKEp1TQR+piTzcqt+7vbPNj1YBJUJNWNqGA7WbHJo3tZIVfCpwiDl21zq2B
         TSWokuI/7Eg9VBdMG3wqMNfJ2y09Kj+l8CzJ5Rbw20PA1Iez/coG47yVyboWBjnmHh9C
         8PFeI40ebEs7tZuxU/2VDPmpddaoQlsLyKRz/xdml2W4YU/0edyLW8v+vlU9n+TOwtdr
         miMLH3R/jfGw1DKndvaAPe4/tOcDYlUZl/Bal7EkPGlV3IZGtIu3CsoRRiZ4WdTHL4cz
         fX16fbVufJ3JxOGTWB943upiw5/ao6OOfc+tJzfPtBxkF0jgHnyHc/bbOMG1mcrCpHpM
         NjKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LUdGXBfqAPYvyyfrGV7234wvLBxAV3i/sSqewG1tWtl31ztTCVVhVjN30e1cIdflfXy7SDP2cCE3GsUl/pig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwpXAgbI3BjfzxuPIXxBP1tRlczUk8c+sSDmKBHWn80Eb6d27l
	paOUGvIOs3n0erTUIJ1icPFQXrN6d2kYz8qJijTXNFfjUOAAMlRndKU6SkUqn1mwiw==
X-Gm-Gg: AeBDietJyK+CXrn/zufRT8qKR7yAAuWbp+FrTlDmaJ21+fdm1ihVsfaX4Cy1IvgWN9I
	xWIMEcpbw7aJw652rzJfSmcXmLi+fUhV2BWuWHqWU9wHfUYtdxeaI4zEuoXSMhvzxUhPqzDE7lo
	CQuUxPbvAcZ+n41cxJsh/vcLj5RQuXIVSYTxVMAwbtO5Cu2ACP79K3u/OF60/cL3gVSKI5BKVkM
	WBjHjWr54W08HXPYp0sLR4ntGOoRpChGUJvS3MdbK1h6inibmntuO5hMO5y3tM6QyIW64kDyXdr
	MU3uhLYYrsEpqygcqJ6yVHwRYnm3d8IERz6YarFJFLLgBjvNJjyXeSNUzqip14MUU6cS4i3dVVQ
	CCpa899PiT0nOxMyluTUcqa1zZ9jx7lBbx8dACKHgg2ITC9plz+FQGdn8FCoKGEj84H8dw7VkDb
	s37IEPxIfG2X5QAdES6rwnlnGYlM5XwjApNA==
X-Received: by 2002:a05:7301:1691:b0:2e1:e5c0:7992 with SMTP id 5a478bee46e88-2e1e5c07da4mr1262505eec.8.1776349608900;
        Thu, 16 Apr 2026 07:26:48 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67::1c9d? ([2804:14d:5c54:4d67::1c9d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f569f4bsm7303516eec.21.2026.04.16.07.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 07:26:48 -0700 (PDT)
Message-ID: <8070149c-87c8-4d9c-ae12-6b9a956fb763@mojatatu.com>
Date: Thu, 16 Apr 2026 11:26:38 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH v1 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit
 enforcement when dequeueing L-queue
To: chia-yu.chang@nokia-bell-labs.com, linux-hardening@vger.kernel.org,
 kees@kernel.org, gustavoars@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 horms@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20260413163711.56191-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
In-Reply-To: <20260413163711.56191-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/04/2026 13:37, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Fix dualpi2_change() to correctly enforce updated limit and memlimit values
> after a configuration change of the dualpi2 qdisc.
> 
> Before this patch, dualpi2_change() always attempted to dequeue packets via
> the root qdisc (C-queue) when reducing backlog or memory usage, and
> unconditionally assumed that a valid skb will be returned. When traffic
> classification results in packets being queued in the L-queue while the
> C-queue is empty, this leads to a NULL skb dereference during limit or
> memlimit enforcement.
> 
> This is fixed by first dequeuing from the C-queue path if it is non-empty.
> Once the C-queue is empty, packets are dequeued directly from the L-queue.s
> Return values from qdisc_dequeue_internal() are checked for both queues. When
> dequeuing from the L-queue, the parent qdisc qlen and backlog counters are
> updated explicitly to keep overall qdisc statistics consistent.
> [...]
> ---
>   net/sched/sch_dualpi2.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index 6d7e6389758d..56d4422970b6 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -872,11 +872,25 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
>   	old_backlog = sch->qstats.backlog;
>   	while (qdisc_qlen(sch) > sch->limit ||
>   	       q->memory_used > q->memory_limit) {
> -		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
> -
> -		q->memory_used -= skb->truesize;
> -		qdisc_qstats_backlog_dec(sch, skb);
> -		rtnl_qdisc_drop(skb, sch);
> +		int c_len = qdisc_qlen(sch) - qdisc_qlen(q->l_queue);
> +		struct sk_buff *skb = NULL;
> +
> +		if (c_len) {
> +			skb = qdisc_dequeue_internal(sch, true);
> +			if (!skb)
> +				break;
> +			q->memory_used -= skb->truesize;
> +			rtnl_qdisc_drop(skb, sch);
> +		} else if (qdisc_qlen(q->l_queue)) {
> +			skb = qdisc_dequeue_internal(q->l_queue, true);
> +			if (!skb)
> +				break;
> +			q->memory_used -= skb->truesize;
> +			rtnl_qdisc_drop(skb, q->l_queue);
> +			/* Keep the overall qdisc stats consistent */
> +			--sch->q.qlen;
> +			qdisc_qstats_backlog_dec(sch, skb);

Sashiko is hallucinating saying this will cause a UAF, it won't.
However it is good to maintain a consistent order here.
For example, see how sch_choke is doing [1].

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/net/sched/sch_choke.c?id=1f5ffc672165ff851063a5fd044b727ab2517ae3#n394

cheers,
Victor
