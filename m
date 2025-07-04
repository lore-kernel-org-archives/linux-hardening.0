Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C372D12E9;
	Fri,  4 Jul 2025 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751629272; cv=none; b=thDVFYb4KtuB/qt+gemWPSyuFHqk+IIfkYYCd3xWJdxvPjdh4wiH/Ls260Goq8fxV0EMuh24Pdet3Q0ln+QYbYxpSKSQhcWf2aI6OH70PEPneovGBtjXqK76fTK7uRhWptJdNAp134ddwSLL8f+rz3n1dyqGF/6gFKnFi6ycLpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751629272; c=relaxed/simple;
	bh=1P5fbya/5ERkcgnx56Lviz+R4IrlpjS+fT5x+gvdqAg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m0DnsfkHYpRiPe3h0BIPh8GkP/UxRY6Vb6rgkkpDQNksniXsiHrGbyoVnww5IX9/O13iTFO0UbwJ1Zj1PdJliQzdjKnnI0xCdrUJmeOO89fq28vDYAt9+pHIVhyvp0QEwY2Ksb/1GLujhjKjYnZGXi6MuI2XdMD1ivKACX0hl2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0//xaVik; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+PghfhJO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0//xaVik";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+PghfhJO"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751629267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spErREiHfGXR/VRbozPh9Iouh245niUjcH51ie8p2Gs=;
	b=0//xaVikHwPYR2TS9cNWPg3LTk1GXVHrgAmF/2atERKQeMbIVt1rFuQ8Y9JTbgdZzP8VAR
	2lD+PPWvtzpSl7Avt6g5HNmFwfln1ZEf27Vve8yc79s7k128mi8aB/OQeDd1azdr9GhgMF
	CTF6GT/VF3uKACHQmZTihaHwizAWo0dl0E7vYa1SS53PzNCdXGwZLXt2n++ki9SvlI9okD
	oq3y7BNpO9xlnAVlgrPbEmn4xPAnpb97C0RsJbQE79mKuKQLtjuwA2uqSzBdgFoxsSIxST
	hTn0w5nmc0WUNrcamvVMSkg5uOI2hzSci8c4mvujSj7YTirvyBKnSisFbOOT8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751629267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spErREiHfGXR/VRbozPh9Iouh245niUjcH51ie8p2Gs=;
	b=+PghfhJOc0wnnPufkj6a3LvxejXeUrL2JUpmzbiypXV49WQWYJOKBg2gvN5xuw2usSFHOA
	vzzj31U09D0g0ZAg==
To: Petr Mladek <pmladek@suse.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Dan Carpenter
 <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Kees Cook <kees@kernel.org>, "Gustavo A . R .
 Silva" <gustavoars@kernel.org>, David Gow <davidgow@google.com>, Arnd
 Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Petr Mladek
 <pmladek@suse.com>
Subject: Re: [PATCH 3/3] printk: kunit: Fix __counted_by() in struct
 prbtest_rbdata
In-Reply-To: <20250702095157.110916-4-pmladek@suse.com>
References: <20250702095157.110916-1-pmladek@suse.com>
 <20250702095157.110916-4-pmladek@suse.com>
Date: Fri, 04 Jul 2025 13:47:07 +0206
Message-ID: <841pqwkwto.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-07-02, Petr Mladek <pmladek@suse.com> wrote:
> diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
> index 0c3030fde8c2..088fe4d8c9b6 100644
> --- a/kernel/printk/printk_ringbuffer_kunit_test.c
> +++ b/kernel/printk/printk_ringbuffer_kunit_test.c
> @@ -114,10 +117,14 @@ static int prbtest_writer(void *data)
>  	kunit_info(tr->test_data->test, "start thread %03lu (writer)\n", tr->num);
>  
>  	for (;;) {
> -		/* ensure at least 1 character */
> -		text_size = get_random_u32_inclusive(1, MAX_RBDATA_TEXT_SIZE);
> -		/* +1 for terminator. */
> -		record_size = sizeof(struct prbtest_rbdata) + text_size + 1;
> +		/* ensure at least 1 character + trailing '\0' */
> +		text_size = get_random_u32_inclusive(2, MAX_RBDATA_TEXT_SIZE);
> +		if (WARN_ON_ONCE(text_size < 2))
> +			text_size = 2;
> +		if (WARN_ON_ONCE(text_size > MAX_RBDATA_TEXT_SIZE))
> +			text_size = MAX_RBDATA_TEXT_SIZE;

IMHO the WARN_ON_ONCE's are excessive. It is allowed to expect that
get_random_u32_inclusive() works correctly. But I am fine with it.

Reviewed-by: John Ogness <john.ogness@linutronix.de>
