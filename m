Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82DD44BC92
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239711; cv=none; b=o912ucbknPW72Y14LozJSZ8WNNMsGVqZuN2n0103lEDy0GERE6ctNY9DMiZzsHO2uuJugyqLFRGRFlEcBRXVEjpROudJJM0SARV32M9A6P/lAbXacxshHA/D4vLHdHhMAO39+h/rMIkZUBd32a7K4akwxrSxszaKTi7fW/4lKCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239711; c=relaxed/simple;
	bh=EwiS1UoxEryAEgswbd9etQy6AAcy4nZ99QGA8vYngAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONiRPJN2KcWhYoHTrvjMaakcU4aMJo7fD1LmXCJ6sFMTsLfcqlJ6ygZ0fEFOaLjXP71zAeXNt1A31wgnFd4Q6nF9NnAbka658lClE7hdt++L89Po/vFTvK0A4HG6aoIrdM0EIqI9LAR+ZaEqAD+abMflQxGp5VrHYrihvuWy/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dbjztXnw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dbjztXnw"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47362928f65so25344f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787239708; x=1787844508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LoFkIzctIdf+SCuk/hYePO6iQk3GRPaknKF20qigqz8=;
        b=dbjztXnwiUeJRsJRFyICyDiG5OWjBejbA30sAMh6MsVIVvx4JHmWRpHgiSOeFj3vmr
         JqcZBATg4lz/mkZXTPf0HRUahihwoE1TZc+d1W+gRTlQw9KmOg2FBeXtZayjgHUh8geu
         JYRNbdulbjX80eZb0bhA7lfx6Oxp6QVIi1O+FDzapRWVCznESUFSxg0la0vXsTyNmWfE
         FcJQjKn4vynilnJpzMWi5oGjenE4MKS7j8fembySp+jJ8ziCnpF0dY0sGgUgjYujyf74
         Wrl7gteiUC06YbbZDFYaKgCaC2OvMp1YIXZMkcm/KjFzvA+XTFdbazD0hxy3tHPPlvP/
         0oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787239708; x=1787844508;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LoFkIzctIdf+SCuk/hYePO6iQk3GRPaknKF20qigqz8=;
        b=aJaTgNlIRTkjaYTgDeR1o4Ece8TtRFotWFzRqO1TYOYthw89jiTZUU4BksG70aTfoX
         c1ELuh5yi3mBuZ3co5erKX5KtCySe83Zm74gNyzVBH5CqV8dJV1t20wzp8tMiXg7rect
         7iuv4VnA3b6ZR8NlQRp1Wtxm1tAvSu+RBDCthEZQFunHyXqetPv7U9CUYNic208ZotgV
         m2soJoQSjki8D2bHXAp8RzoAC9Rwt+VrRYc5O/4vbIyFt7tjU9EOwpInjzXSut4L0XI8
         qtShUyTDdIIR+yK9q4vJddClQwf7ZmHjfsGUgehLi1OxBRYa13v8r4r2xPsQdBwkvVXH
         ZstA==
X-Forwarded-Encrypted: i=1; AHgh+RqlN54B9unWW7pSDdPvMybLjjgIExckTXFFP/mkUEHeLn/oDooD+fzWNa6Jicfr3GPG5Kvgg1AMSPT9DYhiO7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGF2g05I/twT9q2ZTNX4XJYZZoOTahXYKEv4jkyhRSJ+UoIIH0
	GWKKidGGPHS7YUtqF79MHkdMFQQ6mXLbzH2DbQ1/6I9JWPt34yeYcLANf3Y9/oC572Y=
X-Gm-Gg: AR+sD131gJdnaOstDwLFtYA8ZudbvY3c1RVDl7txrxnYhPuifr97HdVR4WpVl9zYU58
	ck1uAKpbfSw+lxTy+IiJ6z0qlPDfLzMcLipnle13Y7gw52LrTBE2LVHSUiS2dq6TdZYy8Ypf7GB
	mWcDo1iKLxK5GhO0SUB6mS/VOGLfbm4kpkqIqNWK7eVLxiYpk3XMts6TkjKT21QnT9AFVaq784C
	fFbIMu/mUfrl8mQSYUri6H14qLI6aA1O08oJqmr3UgdaidLOKaw5OLfjj/XHTDDkpbI2em8CpvV
	fTFGEshXk7y8zSiSam/kKPKkAd5cQ98DTOqVYoFnq8pMpermFZQSvRK+eEQ2UseJqMibMVwiZ0y
	4eMRHCpCqoXQUYSoriWvnV2UGlOfrW4btvVltt2uN8n7DUTiRljJwv1zywMJFl0+XlGxLvBABrn
	lMnWQRIWdh78MBOkZ5Yunn0WZIwrUfBPvqMLWV05J+dYZu+DDbsyTQrlsi0f13Mw==
X-Received: by 2002:a05:600c:4713:b0:499:83f1:398 with SMTP id 5b1f17b1804b1-499aa1e247emr193334695e9.9.1787239707894;
        Thu, 20 Aug 2026 08:28:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482bab42f8esm5909482f8f.28.2026.08.20.08.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:28:27 -0700 (PDT)
Date: Thu, 20 Aug 2026 17:28:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 0/2] vsprintf: Don't leak pointers
Message-ID: <aocdGcA6TYe5ascV@pathway.suse.cz>
References: <20260814144854.746840-1-bigeasy@linutronix.de>
 <20260814125647.3e10a3441ca204855b135a5e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814125647.3e10a3441ca204855b135a5e@linux-foundation.org>

On Fri 2026-08-14 12:56:47, Andrew Morton wrote:
> On Fri, 14 Aug 2026 16:48:52 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > It is possible to leak pointers via %ps without KALLSYMS enabled.
> > With KALLSYMS pointers can be leaked if they can not be resolved.
> > 
> > The tiny series has two patches, one for each issue.
> > 
> 
> Thanks.
> 
> fwiw, Sashiko flagged a few possible issues:
> 	https://sashiko.dev/#/patchset/20260814144854.746840-1-bigeasy@linutronix.de

Sashiko basically complains about that this might make
dump_stack(), panics, and oopses useless on systems without KALLSYMS
which is typical on embedded systems.

IMHO, it is a good point. What about using default_pointer() resp. %p
as the fallback? It would allow to see the pointers with
"no_hash_pointers" kernel parameter.

Best Regards,
Petr
