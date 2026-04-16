Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3A3909B2
	for <linux-hardening@vger.kernel.org>; Thu, 16 Apr 2026 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345947; cv=none; b=TbeByqk0k/KyqaQ3fNNxSOGwVpmVknWX0tLTJPrI1v7FVyPOVhum9CFkYFVBN35wxyLkBGW/4ny+Ohicb0uiTqFME/zP65DELkgsRp7MvDCwAaT45Dk+wHVbTmyFakpXHfOcIPGVyWg0J4+SJGpQzJjHvz7rGyR4dY/kT7BCqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345947; c=relaxed/simple;
	bh=Ks9Lh9sXM3NHLG5RlrbfioY0KnQFqSIq3pvt4kyDJFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jI9MQV43wdj+npZAG760Z5T1PiFdHORt6Yarn2SpTvBKsWprCq8Ad4N9yDZdazTuoynW9yekbbOU3oWkuVGALmTFCA9rNFJh78jP5DrkoUcANqC6afiKdiVsaFvl/rJiQsdRJTiMeRc0Je43uYkuZPEuQBXLtQgfLdm4Q+fvp50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEL0tHJO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEL0tHJO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776345945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXZK7Wy94J2sz6DnNYsgQgumJpWskcv2kpLOs6mdi4E=;
	b=EEL0tHJOl4ix+I/7Bwho61XjHDoowz8az4DfnjzcW2eK9RDh2iWSaHIAZS99vvtLW2x7Kb
	Lol54s6JgCCkN2MIpJdzyAD3mmQT3LNsvsfueW2Sc1iNsNo63fSATyFHzycQ/vzGWdZAir
	8zulcr8kvSZMrVf+xS5nbf2kG4b+N70=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-z8QuffnEOb66_kGa8jOYRg-1; Thu, 16 Apr 2026 09:25:41 -0400
X-MC-Unique: z8QuffnEOb66_kGa8jOYRg-1
X-Mimecast-MFC-AGG-ID: z8QuffnEOb66_kGa8jOYRg_1776345941
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d780757eeso410152f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 16 Apr 2026 06:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345940; x=1776950740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXZK7Wy94J2sz6DnNYsgQgumJpWskcv2kpLOs6mdi4E=;
        b=QT8Eodste0tR1XAC3vNuH1ZN/KnX+4E/8xjOBWCO5Xrb9I0AJdJ1TtrBTIBFL+h3Yi
         393lTgQx7zwEeGmq6DhOOenZxz59yyKNt/6aUKIpt3B3IWeqZ2w/9Pc/Jw+bWsw4g7wv
         yWRNaA85R6EI8NUdxpB6XLK/1KKSzshvjI2L24T+g4H6AeRhgDdLKhXfaXrqvX8t4/iI
         0ohTUfGbzI3y1be6hiRg68aX2qEF/r8MmVpXpXPWDNqHatM+TBYtbVolubEVBw5K+BIB
         Sbfa6tvCJFhPgt/kOX2TVu8S7LtJ/Nk3q5ODLaZIYKO+pCYlrC8vTrL/VrgXOsvJdvXd
         L3wg==
X-Forwarded-Encrypted: i=1; AFNElJ8TXzLgjVmF7qhkWDfDITwT5Wc92OyBgpqzdUOyaNZm+mlvSrUQysN3wBxvV615yMnxmm56RBTEqb4gga5PXiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaaLKegMsf0N1qsYKWSvgTtuyzNqolVFyYozZWVOkDm26PTmWl
	+aSNgM6N4I3yRqFLEHASTRW+LFfNeLpx0g1AVjsXIMYPlwv5Y+nw/XMMCNj7VX25yISIzexWt0e
	8JhLErF0h6D9PoLMDzu5A3lntAYPXo1e1vR5aWM6qmWOMMMwATYo85mEadvhKKnHt5AHzrw==
X-Gm-Gg: AeBDies+DlZRmdi53SwNL+Mpq1Cltp4hm217x3zp+TvwCZANhq3O/879wt/azf4CmWt
	V8PoVJ3VIpIaghP7/U63cGsoKVw2ke9LttB5YOVkUEAu1k787AC6ujCbKEgMO3PoHFAJNeqwi4s
	SrfJCZbKCkh/gVPIoYH1mRjv7TqFWVPgF7q1aXuyhwIjFnP+/WG3OmFn0Wnc5PFuMNup9CWSgaN
	Z+4UzmgE51isJKURF8FtTZdnw8/vnNlZKkRtPDHQWlIMHhGqdZN4g+GdmItzgt07ksAufgOQI6T
	L8IauUKBEDKYFvDgsjuONFcYxITE+Tpsl9P3wW1jU6JWlSM75MZfFfadvvLXCSlFNEbMvISfOk/
	76Y886wfj7FCcfm0g0iad8qUYhhW+SVa8pY93fdS68BBMWhXZHACSAexVjBkXnJgFlLY=
X-Received: by 2002:a05:6000:1889:b0:43d:2d34:8963 with SMTP id ffacd0b85a97d-43fdbb4cd6emr3233684f8f.17.1776345940528;
        Thu, 16 Apr 2026 06:25:40 -0700 (PDT)
X-Received: by 2002:a05:6000:1889:b0:43d:2d34:8963 with SMTP id ffacd0b85a97d-43fdbb4cd6emr3233578f8f.17.1776345939959;
        Thu, 16 Apr 2026 06:25:39 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5fd6sm14487794f8f.24.2026.04.16.06.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 06:25:39 -0700 (PDT)
Message-ID: <9ff2df3e-08cf-4f61-8a58-cac0a6980b2d@redhat.com>
Date: Thu, 16 Apr 2026 15:25:37 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit
 enforcement when dequeueing L-queue
To: chia-yu.chang@nokia-bell-labs.com, linux-hardening@vger.kernel.org,
 kees@kernel.org, gustavoars@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, horms@kernel.org,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260413163711.56191-1-chia-yu.chang@nokia-bell-labs.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413163711.56191-1-chia-yu.chang@nokia-bell-labs.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I23NFUVSDFrYTktyRd3JUn9a9THKh6UYdaiOOLzyrRM_1776345941
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/26 6:37 PM, chia-yu.chang@nokia-bell-labs.com wrote:
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
> Once the C-queue is empty, packets are dequeued directly from the L-queue.
> Return values from qdisc_dequeue_internal() are checked for both queues. When
> dequeuing from the L-queue, the parent qdisc qlen and backlog counters are
> updated explicitly to keep overall qdisc statistics consistent.
> 
> Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  net/sched/sch_dualpi2.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index 6d7e6389758d..56d4422970b6 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -872,11 +872,25 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
>  	old_backlog = sch->qstats.backlog;
>  	while (qdisc_qlen(sch) > sch->limit ||
>  	       q->memory_used > q->memory_limit) {
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

Sashiko says:
---
The drop counter is incremented for the L-queue via rtnl_qdisc_drop(),
but it appears the drop counter for the parent qdisc (sch) is not updated.
Will this cause user-facing statistics for the overall dualpi2 qdisc to
underreport drops?
---

