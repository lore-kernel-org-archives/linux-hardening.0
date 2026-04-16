Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B293128C6
	for <linux-hardening@vger.kernel.org>; Thu, 16 Apr 2026 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362115; cv=none; b=mCJJmWPKFXmi6Y+1R/IF1e9Mozy2bHgeq2s+1By/fH9Ga+PeuJ+lrtNO4VRgaeX36ee/y1bSf0FP1nu7TJ+ydtILDdM2GLkvdUYZXOQ5BncBEWt2RQnPwYJYh53lVbsl0Ny1BNoJ+a9XlUNL2zeMrPJIALhDa/olH9xfmEdRzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362115; c=relaxed/simple;
	bh=weTZRUMhn00reScjqQDzhSuXqozZ5F16/20bwvfN6Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZKfPJ4yI2CheV4Pu/KncdDsEWYhKqktPFwT0UF0n4s+dZ44bjSRl/wZkKW6/iBWRxjBuxddnRC2yGgjkNP6Fsca6jqQyYK8n4Ijs1tSESyW3ZTJyt+FYwf3SBEf+Ha6yBcQG4OQPZG4RPfnlHL1wsnmeMZ3rLVkde2cb1pcSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=wU1zd+S3; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="wU1zd+S3"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c637089ccso2843143c88.1
        for <linux-hardening@vger.kernel.org>; Thu, 16 Apr 2026 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776362110; x=1776966910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7ps5CmpMQpmldkxYFQhE9/S6ubyJ5OkfZHPi2unonQ=;
        b=wU1zd+S34kra7EQrt1pBE8zig5ilnHd8JPXZe8mESGmRoSmRJL5YI6qPAr4emKL0vg
         u57c693kUI9jAijtIAkfiucdifnY8OB1lW/BYD6c6p1dqKfOWVhnjcaSD62Sz6lD6/f7
         HFpLSLcxZOemAHzlHOm4HsOcsMhHRJAkMTWMKXdaoKa/5GixhjuraqtbqVHhCVod+mpS
         S5wgSuuZFtaIIcOx04VIM9hxtfnbWJwEuK8SMMqisDDr2HzYaeB+q8hgPbbWHxvNT/yS
         Rzb4ZZKwHqt0uU1O3vAM3D4UyXeNtS/X17R36Q7gdsoNPBi53gv4/3etzDQslvNBwN1V
         Fmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776362110; x=1776966910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g7ps5CmpMQpmldkxYFQhE9/S6ubyJ5OkfZHPi2unonQ=;
        b=qB29NzY+iwKpSQFamn0BJ1EmmWuvF7jd3Sw5OGewtpXYmG2G1X9cBbAiI+71KE0Ho7
         pAVx3goQNT0/UEUsJoVypH5z9v6X9LMB+YVioll2O1XUYYjaFPYCwOlTgf2OM4YWACtm
         m01APQoCMwK0Iqda1bTG9qbx+DwBcp8uBa1tGzrj0RNDBCnGf1kmNciaij24m20qDi8u
         SUzjV7IdSCYCvpx97TwJ3FJxDuJacShx1I4tw3pZVi6E1jHR436kpqig+QvebLJ7+VZP
         DyKlUyAdz5lsCZi226JRVcXbgK53WJH71itIk8sTjuJt5xNEYfm7NFOyI6sPpnVv4s7e
         UeRg==
X-Forwarded-Encrypted: i=1; AFNElJ8kM++FBbBV/dFlaMXzKfra51zSzTA3UpHN8TwbSPCYZRKGaoFmThWidIEuEBTXcsEjTg9KkZzjVcLu00FZWn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymcfPtPQhAhAocofn8wk+/5lNjsMPOIsmuxqJQWK7hzhJIHDNY
	R4WshNQHxUbekZuXMu9mXa/5D5RYBPlPwRdQKEg6evjtnSsHg8CpwlBgV8H3rSe4K8M=
X-Gm-Gg: AeBDiesPsmafNwCu3+Xo6ULpNokQaKRgjWUvahvM8rKSdUEEGV/hDvEZU+dt8xph9B8
	eHV2L0uvwe1a28xQlAKoLhD701pCVumNK2DKYkmn6fR6DfNu9wesZmVZJQ+hJWS+yuiTYDc9aKL
	Z4TzM5hAC1gnuhqAh8ijkjIp1ebAvGXu1l1am1xC8tXRxEjLZi9mZ2bAMqkqNf/3Rlrtxxz5rbx
	WEfYa0vT2Z6vT6Uq5AZhgJob7ySDtY+J0+I8TyKK6vO30HDl3gP3RQsMVAKUJXFYsDPUYHJPlU5
	FjGO33sgH+CBXpcYyWsllRkj/t6nNCOpTmnR81eiYk2XNPbKO4YN5v7F4LkBP9BPRGghwccAN9L
	/eTWIgpo/kZLo5WZb/1IDxKLjKJSOhabtKcDWPqtQeZesu+fut/z0VKIBBRUe8RXq+lx8wmmD32
	BbZ6et6wwF8v7Q1a0S0npry7rsd1FV2WUqr4C8CQi/f76HpQ==
X-Received: by 2002:a05:7022:6b97:b0:12b:ed30:5b85 with SMTP id a92af1059eb24-12c727e0883mr79884c88.2.1776362109363;
        Thu, 16 Apr 2026 10:55:09 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e61db6bsm6778975c88.1.2026.04.16.10.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 10:55:09 -0700 (PDT)
Date: Thu, 16 Apr 2026 10:55:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: victor@mojatatu.com, hxzene@gmail.com, linux-hardening@vger.kernel.org,
 kees@kernel.org, gustavoars@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 horms@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v2 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit
 enforcement when dequeueing L-queue
Message-ID: <20260416105505.22383f01@phoenix.local>
In-Reply-To: <20260416170906.66432-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260416170906.66432-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Apr 2026 19:09:06 +0200
chia-yu.chang@nokia-bell-labs.com wrote:

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
> Reported-by: "Kito Xu (veritas501)" <hxzene@gmail.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---

I was a little concerned about the complexity of managing qlen here.
But could not find anything obvious.

Turned to AI review and it found some things:

Right fix direction and the reported crash is real. A few issues before this is ready:

1. The `c_len` construction is fragile. Declared `int`, initialized
from a `u32 - u32`. If the invariant `qdisc_qlen(sch) >=
qdisc_qlen(q->l_queue)` is ever violated, you get a large positive
value, the C-queue branch is taken on an empty C-queue,
`qdisc_dequeue_internal()` returns NULL, and the loop breaks out
without draining the L-queue -- leaving the qdisc over limit. Simpler
and more robust to just compare the two qlens directly and drop the
delta variable entirely.

2. Missing else/termination. If both branches' conditions are false
(neither `c_len` nor `qdisc_qlen(q->l_queue)`) but the outer `while`
still holds because `memory_used > memory_limit`, the loop spins
forever. An explicit `else break;` guards against an accounting desync
becoming a hang.

3. Whitespace: two lines in the L-queue branch use spaces instead of tabs --

+                        q->memory_used -= skb->truesize;
+                        rtnl_qdisc_drop(skb, q->l_queue);

checkpatch will flag this.

4. Comment style. The three-line comment at the end of the L-queue
branch doesn't follow the net subsystem multi-line comment style
(leading ' * ' on continuation lines, closing ' */' on its own line).
Once the code is cleaner, the comment could also just be dropped or
shortened to one line.

5. The accounting in the L-queue branch is correct, but only if you
trace the enqueue invariants carefully: L-queue packets are counted in
*both* `sch` and `q->l_queue` on enqueue (see dualpi2_enqueue_skb lines
413-423), `qdisc_dequeue_internal(q->l_queue, true)` adjusts l_queue's
side, and the explicit `--sch->q.qlen` + `qdisc_qstats_backlog_dec(sch,
skb)` adjusts sch's side. Separately, the C-queue branch now quietly
relies on the post-CVE-2025-39677 semantics of
`qdisc_dequeue_internal()` handling parent backlog -- which is why the
pre-patch `qdisc_qstats_backlog_dec(sch, skb)` could be removed.
Neither of these load-bearing invariants is documented in the code or
the commit message. Please add an inline comment in the L-queue branch
explaining the double-count-on-enqueue, and mention the
qdisc_dequeue_internal() dependency in the commit log.

6. Commit message / subject. Subject reads as if only the L-queue path
changed, but the whole drain loop was restructured. Something like
"sch_dualpi2: drain both C-queue and L-queue in dualpi2_change()" would
describe it better. Also, on NULL return from qdisc_dequeue_internal()
the loop silently breaks -- if that ever triggers it means qdisc_qlen()
> 0 but dequeue returned NULL, which is a real invariant violation.
> Worth a WARN_ON_ONCE().

Suggested shape:

	while (qdisc_qlen(sch) > sch->limit ||
	       q->memory_used > q->memory_limit) {
		struct sk_buff *skb;

		if (qdisc_qlen(sch) > qdisc_qlen(q->l_queue)) {
			skb = qdisc_dequeue_internal(sch, true);
			if (!skb)
				break;
			q->memory_used -= skb->truesize;
			rtnl_qdisc_drop(skb, sch);
		} else if (qdisc_qlen(q->l_queue)) {
			skb = qdisc_dequeue_internal(q->l_queue, true);
			if (!skb)
				break;
			/* L-queue packets are counted in both sch and
			 * l_queue on enqueue; qdisc_dequeue_internal()
			 * handled l_queue, account sch here.
			 */
			sch->q.qlen--;
			qdisc_qstats_backlog_dec(sch, skb);
			q->memory_used -= skb->truesize;
			rtnl_qdisc_drop(skb, q->l_queue);
			qdisc_qstats_drop(sch);
		} else {
			break;
		}
	}


As with any AI feedback, expect it to generate hints but also be wrong.
