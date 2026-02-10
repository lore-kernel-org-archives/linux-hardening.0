Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BB133B6C9;
	Tue, 10 Feb 2026 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770712912; cv=none; b=Q8a80df1iIgpYI9g05r9IVIlg/zlHxdrMa2qsX86+TQC4Ke6ULVfDn6Ht81hAiXNuXP3UPxJ3HFaUJSbzAUo/D19M3N8zrEOCbG0hn8xQj8JMGnz/WnpSvU8RDnMErZwUVi4QHlYp+PmwoYCbletpc6N6f6WDiTSkxeQ9VIJtG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770712912; c=relaxed/simple;
	bh=BUZauHUvzJgggungSLkUNWiggLCxRRTu3jIqZuxwAGQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NcHpi4uOC9mULAjn9V1ns4Fr2CFtof6i5EOjxYKIbhRnN5xMQRNWNb8TgGHC1q8anQoVpcnrKLxdz2kbcj6IfLxxsQ7DjLwG4WTCr5V+Np9uj8AlLgG4mofKiDxAwhQVpDv7c/AQCf/dtgRHywfb9/6EbjQMi0PC/Qw8OVL4OOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bazB5idg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vRGobxHJ; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bazB5idg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vRGobxHJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id D49491300A94;
	Tue, 10 Feb 2026 03:41:46 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 10 Feb 2026 03:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770712906;
	 x=1770720106; bh=NVt6zdzuxxUdmKRAXiJ+AdesYtwQIrVUaYBRhDszmik=; b=
	bazB5idgjrjJLgAf3YRDx3DUYdJ8lqBAhEDaZcXwjfJemdw4mUCH273RPrxGOvDq
	EHj70Sy2nN6VVvbyXdQWFL6nLMBbQyqmXkuRojNDOF4d8aanHsfdQgqPBFhtgExK
	hW9JUFWpdN35wfw9OIwfVsblcCDFQ0zoY3yqFOehnbS4bqwV7X8VYFG3CRIpQZf/
	JDTA03F45+REUCgoLddrD13kXf2GsKuluuH2MLhbmg/x2Sq1Y/ieAR5JNPZ6453u
	yff/TkaiuHwe+t3Xsfjy5Z+vS8RzOtf2w5byAn2NlC49lEtvwDykjWe/UwVTkCYj
	bkagm3uKl4vXUcVV/QFgNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770712906; x=
	1770720106; bh=NVt6zdzuxxUdmKRAXiJ+AdesYtwQIrVUaYBRhDszmik=; b=v
	RGobxHJg/ab5SjxMQcDSIQhnR+RCUuqo0c/dhBXtN/yhJbJAZJw9QjBZ1GwtV3Tw
	82D/AUbI6zqdp8C8LjrBZWVp0B7WwgpE8pXz4k1DgQXWOs+dlWRI6smerkZnLGgu
	hWhXglOxuhTSf7ycDEX84UGek6TNFiA5B12yX13FUOmkBrQdoajxj3uv4Amwn3az
	xkN8Ca71ME/rtagyz1zlK91jJcmYbggvmlOeW+9Ww+TyrLVkkPStI3VhA2yaeCZy
	/uYdfSWk4kV7gr1RN4IgD7ROghkcNds8SttsUdehSfrL1SHvuW3VPcK0JHnrL27K
	xrYpIdaQIKr1vvJ66XF8g==
X-ME-Sender: <xms:Se-KaaiLgE8Cn-RHEut2nJqMQ3tN2JKEZ8pxMMHDE_drbY43bc14Yg>
    <xme:Se-KaV06o6FpfJMe1k9uGrwT4AQtkqOxTN9aXk39-M09pV70SKUshXSKtMZCK0Q-i
    TDoSEUTv2Ta31pgrRj1jVujizxoRacllu8kIeMr7oUv0nQRI4_k70k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleelvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepgefgjedujedvieejgeelgfdthfduffeiteefudeghfffkeejfeehtdejfeejteef
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgvfhhfgihuse
    gthhhrohhmihhumhdrohhrghdprhgtphhtthhopegsrhhgvghrshhtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepnhhitghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehusghiiihjrghksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhushhtih
    hnshhtihhtthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhhorhgsohesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:Se-KadToGxgJ8Kk_xX7AzskBeEwQo1sw2iJkRMm2v1WcIFct-G4xFw>
    <xmx:Se-KaUPgWiXHzfvEL37woxhPgI7KJnSWomy2K7gNqjbuuSxjK3GhzA>
    <xmx:Se-KaSxqQoNl-e3QWF2oX6zEWIsm49W_j_rXZn_OnnrgAc1ScsF-uw>
    <xmx:Se-KaWpVfwEZift3s9tWOP9kSuiGA8TF1BXzROfLLov-2OWRmAZCVw>
    <xmx:Su-KaWdn0qMRE4yZiYOHILjL06yU046z7NS67fGCoiwb06nlRr-AvQRH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4E7F6700065; Tue, 10 Feb 2026 03:41:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ays0886HgnbJ
Date: Tue, 10 Feb 2026 09:41:25 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bill Wendling" <morbo@google.com>, linux-kernel@vger.kernel.org
Cc: "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Miguel Ojeda" <ojeda@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Marc Herbert" <Marc.Herbert@linux.intel.com>,
 "Uros Bizjak" <ubizjak@gmail.com>, "Tejun Heo" <tj@kernel.org>,
 "Jeff Xu" <jeffxu@chromium.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 "Shakeel Butt" <shakeel.butt@linux.dev>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "John Stultz" <jstultz@google.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Brian Gerst" <brgerst@gmail.com>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 "Jan Hendrik Farr" <kernel@jfarr.cc>
Message-Id: <d29ca795-ade3-454b-816e-46b5815a1444@app.fastmail.com>
In-Reply-To: <20251121193957.1655580-2-morbo@google.com>
References: <20251121193957.1655580-1-morbo@google.com>
 <20251121193957.1655580-2-morbo@google.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: Add __counted_by_ptr macro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 21, 2025, at 20:39, Bill Wendling wrote:
> 
> +/*
> + * Optional: only supported since clang >= 21
> + *
> + * clang: https://github.com/llvm/llvm-project/pull/137250
> + */
> +#ifdef CONFIG_CC_HAS_COUNTED_BY_FOR_POINTER
> +#define __counted_by_ptr(member)	__attribute__((__counted_by__(member)))
> +#else
> +#define __counted_by_ptr(member)
> +#endif

Something changed in recent gcc versions. I had tested gcc-16.0.1
successfully with CONFIG_CC_HAS_COUNTED_BY_PTR=y, but after upgrading
to a recent git snapshot, I get this output:

fs/coredump.c:95:15: error: 'counted_by' attribute is not allowed for a non-array field
   95 |         char *corename __counted_by_ptr(size);
      |               ^~~~~~~~
drivers/misc/lkdtm/bugs.c:518:15: error: 'counted_by' attribute is not allowed for a non-array field
  518 |         char *buf __counted_by_ptr(len);
      |               ^~~
drivers/misc/lkdtm/bugs.c:520:29: error: 'counted_by' attribute is not allowed for a non-array field
  520 |         struct lkdtm_extra *extra __counted_by_ptr(nr_extra);
      |                             ^~~~~

This is every use of __counted_by_ptr() in linux-next at the moment.

      Arnd
