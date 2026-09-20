Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A57353A77
	for <linux-hardening@vger.kernel.org>; Sun, 20 Sep 2026 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789894718; cv=none; b=HXNsHisEQxoGXGQ5ishOGqXVDB+xttxXAY9S3Xbj0NwgLJVqTOM+uKI/QmU7ndMy8e5t5S8N2b5ssMTDy0C6XQbQ7hA1jf3O+SXuNEoynw6TbbWgirVkRMLJazBhg0/JVoARHsp4cxS3bW4NHJ9Vafi5DrKx7beay+BNodj9eHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789894718; c=relaxed/simple;
	bh=ulT7ug30BS3kQe8AssR0HTE8pww9RYiAYwua19h4QeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cx2HEnWpotL+ApixSS54soLGjt9UmFYr8dC/1KeLl8z23bL0SpOVSpfzMEH5iSMRFGAqodytmWUYbOHT+2blA9eHYwXx1yh7j5KSbTSHSnDYQSJ9xeQkRLVOsxhivVLAbzd3BH4XTdQ5GHSEYgsdFvXJ9g/iklmV+NtjwIO5Fqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0XlKD78; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0XlKD78"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so1415465f8f.0
        for <linux-hardening@vger.kernel.org>; Sun, 20 Sep 2026 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789894715; x=1790499515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kVcSeGrILNL/3yAIXQLY6tssLOIk6fAE7TJXvBIsnxM=;
        b=W0XlKD78YUi8OKyOmLeXYSGLZf/wcsx7U90IFwKjFc3KYMaSacH6eWEaQtlNi20n/G
         nZ07vtej1YaOHm//WAbW20BWuz4fvDWOcEpAhcd31X1BcQWHcEmftXtXYL9FrNy4Fcv7
         IjiDq0KIST1GOxeaMzfcyc+h0do/RL+Y2aPDjSUuFnuTYv2mG/w4A1ZkBzswirsFUpvu
         Xysn43OazS93mD6y2L3D5JIU0Q4wvMWlFIdlTYWTqRj3aB738/H0RAS+RJ5PaIR800dK
         XdhLlCRLLc6MVN0/sNv5bN7IK+C9eCi1IU2AB4T/LMYCH3YijjjzqvvvCCDuwEzGvcxJ
         KI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789894715; x=1790499515;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVcSeGrILNL/3yAIXQLY6tssLOIk6fAE7TJXvBIsnxM=;
        b=Ak8hFBMlC4BgWz7ie739uB/dlk7rWY0/8Tt0hoAo9AVHhSRu7kDOY56poewam5XIQV
         Iz4r6lqYxRMSRn1qKuFDvAApjphVuizX4DFCTuvZLBy/DMybZNdG5htnOmR7E3kDkalU
         IHMASDLpHPTsBYBXKVM941HGjN9AmA+jWT86Wk0bX6J7hN0iittJeQoGxd9MVnxQlf8/
         YzuSTE5UEeaWZKcModjbm4rucYv8MfanIeJ9OM689MtIxR8uemB4DQzN67xUJu2GzUcs
         3FErn24vrz+IxNHNpqsPUE4wRTToYuuoHXEJ6b4kxQJ0oaRP9nNBjK8c+4dxHFH0ozgM
         JS4A==
X-Forwarded-Encrypted: i=1; AKwUvBxABhTKnDA9l0YVPx6XZMtmxHoY/5XDqZQUSkGLquqRsfmn2NfrL++0LQqOQxUKoTuilZrscgKiYtatreAre1k=@vger.kernel.org
X-Gm-Message-State: AFuF++l6+CDI2NMvEeNeZ2z04uKsOjwgE7DDqqI+rU7jXtyKejiO1X7Q
	vkJNe1AB5HOhBvrr1Qsr8HG5WKVr5CHWdY/5NwcI430Yxs4zcr4eu2U4
X-Gm-Gg: AYBFou0CRdY4pS0EtCVvfM3Omsj33KTNj+mYVRLxvjNQhVsxAvgPufi4Bhj/9LND1Q6
	mvnnKNE/ifKqe00n9nAxOGhnY4SFq5v4xGj8AkM4yUCwl4IO1qvH6Jq0T8zdbzDPryjoXWuiZXR
	qw+ZSWN/nZpepYZbo28re38WfBfMWUFcznOTPMfxaI9rjIcHPuPNYx3OfZgjFmuxBNTQB5hxeuV
	ET2fexfJyDUylai+D1tfSxQ4siGXqcXJQSUcSRS/6hIyTz52YQ4QjNk1iWGmoAOXUAq3PseOXhO
	E9v9dux5hIWMR13dcLqCv4ujBq5lNiEvP1dSi5i903BzLqbByUEc62VxjLQ3PMZ/ypVde42xul0
	DtUCBPL8WWZVWEo7BzMaI8N7kmpZhX7lD0zKdJ7UTytt0K8VWp+djPpKYrn8blExzr2MGoP2Tkt
	I8+ysYfwlPR6UtbtQX1BL12PNtPlzuLPR9+ObvakPkh5OYPc6ve7dsUxv3q27Wu8Ote0bcm1cSl
	Oa3QPdnEPqSU7Mlr2qQkN7CTLe33ouztkff
X-Received: by 2002:a05:6000:26c6:b0:487:fa6:d7e5 with SMTP id ffacd0b85a97d-4871e386ffdmr15519930f8f.25.1789894714784;
        Sun, 20 Sep 2026 01:58:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724460978sm12865886f8f.11.2026.09.20.01.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 01:58:34 -0700 (PDT)
Date: Sun, 20 Sep 2026 09:58:30 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, David Gow
 <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, Shuvam Pandey
 <shuvampandey1@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 nikitash.mariiaw@gmail.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 5/9] seq_buf: Add seq_buf_strlen()
Message-ID: <20260920095830.6f56f66d@pumpkin>
In-Reply-To: <2026092037-antsy-shrapnel-6139@gregkh>
References: <20260919002658.stay.929-kees@kernel.org>
	<20260919002714.4060307-5-kees@kernel.org>
	<2026091953-cherub-empty-ef35@gregkh>
	<202609191326.4042FC4@keescook>
	<2026092037-antsy-shrapnel-6139@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 06:34:32 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sat, Sep 19, 2026 at 02:15:58PM -0700, Kees Cook wrote:
> > On Sat, Sep 19, 2026 at 08:38:37AM +0100, Greg KH wrote:  
> > > On Fri, Sep 18, 2026 at 05:27:03PM -0700, Kees Cook wrote:  
> > > > +static inline size_t seq_buf_strlen(struct seq_buf *s)
> > > > +{
> > > > +	if (WARN_ON(s->size == 0))
> > > > +		return 0;  
> > > 
> > > Why WARN_ON()?  Are you wanting to just mint new CVEs with this code
> > > path, do we not give out enough already?  :)
> > > 
> > > I can see returning 0, if it's empty, but isn't that a valid check for
> > > people to wish to know at times?  Why crash the box?  (remember about
> > > panic-on-warn being enabled in a few billion Linux instances...)  
> > 
> > We have to figure out a line somewhere. :P Making a seq_buf with size 0
> > is a nonsense construction, but seq_buf_init is non-allocating, so
> > there's no feedback about setting it to size 0. We could move the WARN
> > to the init? I was just following the existing style here.  
> 
> WARN on the init makes more sense, but even then it feels odd as if we
> wanted to make a seq_buf with data from a device or userspace, we would
> have to verify the size is non-zero _before_ creating the seq_buf or we
> would crash.  So someone has to check the "untrusted" data somewhere,
> right?
> 
> And why can't we have buffers of 0 size work just fine?  What prevents
> that?  People have "empty" strings for lots of things.

If someone passes 0 to an allocate you might be able to use a global
char[1] buffer (that always contains 0) just to keep everything happy.
In particular you can return a '\0' terminated string without adding
conditionals anywhere else.

David

> 
> thanks,
> 
> greg k-h
> 

