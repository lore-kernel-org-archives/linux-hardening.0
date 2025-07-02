Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015782D77F6;
	Wed,  2 Jul 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471302; cv=none; b=WREzYV2tW5aT2qV5Gk25KNezq4eM8+pbUuU6KuWMekH0jD6rpZ56OMhubn606QcMZ/Wmqlup9WsarYu0aJl0NmIQZbmTGah88AI7h4tC+00e/zQhYXQVD7KG+msA57MqFX2DazksLuVzkaM9Rrk7LYfCXxAjDu423I87wA24ygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471302; c=relaxed/simple;
	bh=szBu4cc71UNcL+UQ95Dz075O5wiuTepXP1WCmzIERqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acQStpgzv4NAHTM/pDKSnq4PS5vmGXokPObe9SJo5NBAVKCDDmvxlKIp/Gw9qsMyCX7U7Q41tsa4XrxY38jWmFG+53TyeYyreuMZf0N3O4/1/yLr2RsZ5YADcb8qA7H1jj38M0hxTPxV0DgrDRqT6BvNIKKZvLhpgQ6gUEqAr5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f73bxgMn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bATw47+y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f73bxgMn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bATw47+y"
Date: Wed, 2 Jul 2025 17:48:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751471298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSAVK0GU5TWvXP+ODZ1ziZYG6SMkFJRoffezLtLsz/8=;
	b=f73bxgMnF1fBcS7WXOMnc6kEja+iUcHcyagqhNxHnFA2fkyvtpljiYainf94Q1wkk0k8oL
	5yvSfYugRQWx6zI0tXr9RjcjOMu5nL1M3XVyRw6LvHjXEMTfL8SYhxvF/2lxvvV9r9iOT4
	wlTxu1LZFmf2H5x6CRoeHn/y9X4FmGw79vOV0XEf9GC3ikXzcUiEp+JXKWtzGgLSl7+EcK
	PC7ZP9JH9uNONhojtbblSkZwFEXzr+52EORT2ILSRwH9iZBv2NHSsJbFNsIP7jPgOhc4+G
	3MyPOttZr2+/w7DREGC4Uhuuy9/pVxEDNONgZdHhQUSHRylJpu7DfGQMo8+G+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751471298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSAVK0GU5TWvXP+ODZ1ziZYG6SMkFJRoffezLtLsz/8=;
	b=bATw47+yUelqg3qqSU03c99ONUHLykGWnnniK+I7h40UvsM5J7rSF52vHgQ5eNr2ugVC1U
	t0bxUVInbK1Mk9Dg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, David Gow <davidgow@google.com>, Arnd Bergmann <arnd@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] printk: KUnit: Followup fixes for the new KUnit test
Message-ID: <20250702174519-0b0fb0a9-3e9b-4a1d-918c-f1a57d2c2935@linutronix.de>
References: <20250702095157.110916-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702095157.110916-1-pmladek@suse.com>

On Wed, Jul 02, 2025 at 11:51:54AM +0200, Petr Mladek wrote:
> Hi,
> 
> this patchset puts together some followup fixes for the new KUnit test
> which were discussed on several locations.

<snip>

> Arnd Bergmann (1):
>   printk: kunit: support offstack cpumask
> 
> Petr Mladek (2):
>   printk: ringbuffer: Explain why the KUnit test ignores failed writes
>   printk: kunit: Fix __counted_by() in struct prbtest_rbdata
> 
>  kernel/printk/printk_ringbuffer_kunit_test.c | 78 +++++++++++++-------
>  1 file changed, 52 insertions(+), 26 deletions(-)

For the series:

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
