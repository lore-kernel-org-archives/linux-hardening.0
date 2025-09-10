Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65F21B425C
	for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520355; cv=none; b=mhaMe8zqlGIxqa6xFPAzqbG2XuO3hP5MEh4/WcDulwy2doNjTuJVTW9M2L58I1yyH6wbiC+PeYcN4OnD0M9VETi+Juxt0yorKv8IseZIzOfpKTFx9tq/mkabrzXvaK1CQe/EnB5PUw+2MUnAfyEeFZRBjwaW5LNvIFNxO1Gk3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520355; c=relaxed/simple;
	bh=VYJEE0OdCF+OcIqloLm/1BOl4kW/iGjF5av4omVk19U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxn+8vzZaWlkvhDWM5aJcumdaIENbu2LIAkFzpPc8bM9+omlSGrLrTv4TrY1ZmXrSZERU8otRR5TZlCa9cXODabqrOBudjuDf+M58iXqeYm1Ydtr1fnn0PtGccE4qCIuiibBSCY/EEgeMR38wWaMOg8L7nHj1+i7ySfpsUFOlzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z4nQYplB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z4nQYplB"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b046fc9f359so1222529666b.0
        for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757520352; x=1758125152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l7C9yj707Xq302+3n2Zc2uqWZ1bCZ56pptu3TpPal6c=;
        b=Z4nQYplBt5vX/B/RotfXT2IjXumVWnwNZMEbMhy1siyMd1UVMwVlGGMHPOV9Dt75WJ
         Ax19cFy5EZP+gmdia0kAE7l/jKtm+abl2d90oAlENMOFqg/rAufpZFd3scFp/9Ewu77I
         kpO72BJookWVgBISCUqu4orCltakg93fw4EEmKZw7Dt6r/32bs+CMlGDdBqDLG+LKy/V
         6hygJNmFk2wAe3yRtLdAuTHnQtAKKYxohUsTeJi8NzgYHLzgw372s2dVWIrF7egX2Jh+
         z8QvaKexD6WLdvDbX72zPS14vGqxcFw+hakqcc7sGjQeDmVd/p0IvVwAdGWEpwFNXf8X
         CViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520352; x=1758125152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7C9yj707Xq302+3n2Zc2uqWZ1bCZ56pptu3TpPal6c=;
        b=hqdZfbTTQOv1LxTy46xdfUwrv9Sjamp5dg0pk2LWC91BlYvx/ZyQBljd/jFiewpnqo
         p79VaRkkImt3UyIxZfdSTeU8/t9zarRTFxJbmeHwj4RqwdYLertlXgImSVUxjMkYtl6H
         ChCMPs4miB6pJnpigdYWqQUHOcNsJe2icjLggr0Y9U5mSpoD+WcXoFKtCs1kkvtSo7Ng
         REx8QurR/cKtiOBBAkX7D1ZhoEsMyNbaT02axGJcZ97V+2avMf7zm9bHXX2mmwCXY7zM
         q1lXmvqRG1/d2V2VA0BrdaH7Cyzhs20xSPRMwdKs3qNasvrXmSdKWcVb1uo/6FcmYzDx
         sSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9at8gK/WXcqozi1IwkgBArk/0DKH/VTozlfo6ziTgx2vUe3T/iDssAVJD0bpJhhAPSov+rfoSH9g60N2bSqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJZ8SKV3h5XFTYNW4NzDJUJuePly7U4ISXXPwYLqu+VSbps01E
	yRud1TYcY9hxWi1p10Un8AtPOqdogd5wsJp1mznVT5GQ156Xs6vacwW4DmG2YGZ5TJA=
X-Gm-Gg: ASbGncuhhIgQTAxtWBHrIquhEcVgPHYsCZLAtEqnXxLyUws3VqvUsLlBjrx/NChbRRg
	W0YbUuPLnKlZUy6hms3nTNIH/4G0DxXWsW/NEDb6HrhrqVBq0OtLXfpCcUiWXNhPcB1KVsO45QA
	RApM52EXXNDu2GogYsSO1b+uSF3YkI0A4g/m7k2ej+G2zIne64lZ6uj5xmKKO0xtA0uy35GWdSX
	9q16MWnB3Ere9hWWKfBNGV7uzyfmTEtiIwhHcWcef+UwOFzz989Ugk/w+BtGVIph3phnssAX6jJ
	8tbaeDXaHoYMUVhG7Dv71jmc41baPA6e54m4CDDWCpqUmNldLML0n5Kj5k6KeQuSBWGY4toElrA
	eXSVBTlOawwQKgit7xGtIr9yjfm7jeri+g/3q
X-Google-Smtp-Source: AGHT+IFYx0f6DUoknE3dgFPXDXGKuGYnSTvQRdBOTBBtYYwAndaqUysHWLmorf5AgzT60bAXrTya6w==
X-Received: by 2002:a17:907:6d0d:b0:b04:ae7c:703e with SMTP id a640c23a62f3a-b04b140a770mr1479252666b.24.1757520352091;
        Wed, 10 Sep 2025 09:05:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334d74bsm189650166b.57.2025.09.10.09.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:05:51 -0700 (PDT)
Date: Wed, 10 Sep 2025 18:05:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>, Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] printk: kunit: support offstack cpumask
Message-ID: <aMGh3QqB4eNsUjf5@pathway.suse.cz>
References: <20250902140326.344214-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902140326.344214-1-pmladek@suse.com>

On Tue 2025-09-02 16:03:26, Petr Mladek wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> For large values of CONFIG_NR_CPUS, the newly added kunit test fails
> to build:
> 
> kernel/printk/printk_ringbuffer_kunit_test.c: In function 'test_readerwriter':
> kernel/printk/printk_ringbuffer_kunit_test.c:279:1: error: the frame size of 1432 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
> 
> Change this to use cpumask_var_t and allocate it dynamically when
> CONFIG_CPUMASK_OFFSTACK is set.
> 
> The variable has to be released via a KUnit action wrapper so that it is
> freed when the test fails and gets aborted. The parameter type is hardcoded
> to "struct cpumask *" because the macro KUNIT_DEFINE_ACTION_WRAPPER()
> does not accept an array. But the function does nothing when
> CONFIG_CPUMASK_OFFSTACK is not set anyway.
> 
> Fixes: 5ea2bcdfbf46 ("printk: ringbuffer: Add KUnit test")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [pmladek@suse.com: Correctly handle allocation failures and freeing using KUnit test API.]
> Signed-off-by: Petr Mladek <pmladek@suse.com>

JFYI, this patch have been committed into printk/linux.git,
branch rework/ringbuffer-kunit-test.

It worked, I did it according to the feedback. Let's give
it some spin in linux-next before the next merge window.

Feel free to ask me to revert it, ...

Best Regards,
Petr
