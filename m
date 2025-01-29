Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219571922F5
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jan 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159622; cv=none; b=FQXkqvsaqRYoPrqzOK1Kl+D75m0x+/l/8KczPQSDCRaC3vMJqurKRnRPUmHuiKhafKhtRsr6/8GaLYs7c+WvqrsvuSg/YO9vqd6PO/YXGICWtlI3E2ksi6AhyMCYIddd3z2F8hKhBcJxzGLcxucKQQZNEjJF3ku9HpQrOz15Hy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159622; c=relaxed/simple;
	bh=0oqbYSqMzR5BC2SYSdU2hgzMX3TTGyHmwAOHuZJrCHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdJaEpMUOIuvBrGHAAUnss2Qv0iwg+ust7/g2rWeq7PvKoyhEQnB2lMo+IrQMbeCDKrF1zuA+RB6cS1MmcULPm36G7NyCMacc1Bs2sldcmg2+w3jj77ViuXN38stPOuuOAVRvTiC+Z1EWCj66tFV+uVd/Q6TmEj8xIZlU0oBW+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X2ovEZGB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2ovEZGB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43635796b48so5433625e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 29 Jan 2025 06:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738159618; x=1738764418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bG50zjaH0VQq5duenMAZ/yyFRhpZ3VsB6Mcg50lZ728=;
        b=X2ovEZGBxWqKYgHJvg5lIoIrWBmhHwlB9UaOZHFs2YY3nZrWzLdTM23o5BTE26PkWJ
         7UjNa8XSL8XttfU0ptrKQauKvg0HKf3ewx3Ge6ij7C9Fwb59EMTK/XyXaadmd8wa4I2T
         5fGwq25FzB50xKETTBuluQwIAz9rWQUgUwMyVBsDZcD6aS6iwhA1lsScpy5SWoXP7O01
         Pj8uX58Nrn26d/DunrzCziF+/KxrfCYYGWoEP58H/cjWuUty6ToJSimtdrCszpdRGlsu
         1tTqRPp0rlpRMPVK4AOJVhmK7ZpouIVSP7wwyUuZlDAkYTVsKs2y9Fae4J/Q/7Z/43ai
         incw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738159618; x=1738764418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bG50zjaH0VQq5duenMAZ/yyFRhpZ3VsB6Mcg50lZ728=;
        b=AG2DdjPT23b9Fs6QW+7spVXb0YfwI0ZEEb5IjRND7k/qX9s7dgpo3Xyc+Z5c82UW7c
         e1wAd2a7OHl2U0N1hZYHKXRrUA7o3ObO2Efu3yohhVOVIIXvWdz6yC5wyMf6GUb72YKJ
         AQXRfRECCSyjie6GY5K3dzqS+FlmYVto7XVN/iSqFMQMxWZ1axjoM6eUmvBDW62VDw0x
         oa6wbpzN0ce1W0edvVpStuanJB6tvKAfv47SLOdutDMIqDSPLcbovn0BJGTTiOBiA955
         3V2CQbOwcEilXuK+JeX71a5Ms2Kqd1EDrWcWjRSRBdpqjsdJuSAvK2ul3CKcRvkVBec6
         SkoA==
X-Forwarded-Encrypted: i=1; AJvYcCVNkD9cENHvQaLevssXe2zagPdAv89tcTDCgGyTaMqD6scV7qStqKTekV4TNOlYrBOxaTzWFlqBBKXupaN/yBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySZYZ3f5DhgbX2rTnH0M9BzhQL95Nzi1fp33jWDeN2rIpftFlI
	7zJeADBPKhohiAdUpkfY+pv/iMgBv0KpEqpx3WZbRia//sHG6FXXI0YdTvPY8EY=
X-Gm-Gg: ASbGncvLycLHG7lSQCMnx2EGOHnw6HCmuGPEBxIFawNKS2ajymr6lpJmkUKLE8SOA1W
	Kiqia61cns95chlWBv3mvXo8kKwP5RxI16/eI9pzI0Jb4JcHEwzkMwVC62Py3xzVbQzs7EIn6As
	XcoWa/I5GpJmkHS3PGd297oEaqhoCvNOInj511iw6cJ9AuRtJs4bac0jD/pkY570x5/OamKYdIA
	3d3gGxdtJeivFc/BJgzfgFZvrUABx/QFbb5bybXRLA9MEKhfAs5g8buor5Y2hKPKzJGfGOdPoDh
	tgtBSz1Q5iLl2KHPnMbI
X-Google-Smtp-Source: AGHT+IGppIz3FFFulk6wi89F9D24oagBc4AxX7sUQG+q/0EOoPmy6Sgd7sFPca8nukKltW3E9MQ4Fw==
X-Received: by 2002:a05:600c:4f0f:b0:438:a313:cda9 with SMTP id 5b1f17b1804b1-438d599b9a0mr65389755e9.10.1738159618142;
        Wed, 29 Jan 2025 06:06:58 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc13151sm24152535e9.1.2025.01.29.06.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:06:57 -0800 (PST)
Date: Wed, 29 Jan 2025 17:06:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] container_of: add container_first() macro
Message-ID: <3979f87d-b7d7-48bb-b6ab-cd8165dbc3cc@stanley.mountain>
References: <Z5m76U5zh34WbeQY@kspp>
 <2025012955-hypnotic-patronize-8931@gregkh>
 <f6e24dfa-450e-4de6-87a6-6fcf7d83888d@embeddedor.com>
 <2025012921-dense-unplanted-952b@gregkh>
 <06aa1194-a7aa-4a5a-adb8-f6cd447d35d9@stanley.mountain>
 <2025012951-plenty-clang-1e2b@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025012951-plenty-clang-1e2b@gregkh>

On Wed, Jan 29, 2025 at 02:14:14PM +0100, Greg KH wrote:
> On Wed, Jan 29, 2025 at 01:39:27PM +0300, Dan Carpenter wrote:
> > On Wed, Jan 29, 2025 at 09:34:07AM +0100, Greg KH wrote:
> > > On Wed, Jan 29, 2025 at 06:35:18PM +1030, Gustavo A. R. Silva wrote:
> > > > 
> > > > 
> > > > On 29/01/25 16:24, Greg KH wrote:
> > > > > On Wed, Jan 29, 2025 at 03:56:01PM +1030, Gustavo A. R. Silva wrote:
> > > > > > This is like container_of_const() but it contains an assert to
> > > > > > ensure that it's using the first member in the structure.
> > > > > 
> > > > > But why?  If you "know" it's the first member, just do a normal cast.
> > > > > If you don't, then you probably shouldn't be caring about this anyway,
> > > > > right?
> > > > 
> > > > This is more about the cases where the member _must_ be first in the
> > > > structure. See below for an example related to -Wflex-array-member-not-at-end
> > > 
> > > That's fine, but that's a build-time issue, you should enforce that in
> > > the structure itself, why are you forcing people to remember to use this
> > > macro when you want to use the field?  There's nothing preventing anyone
> > > from using container_of() instead here, and nothing will catch that from
> > > what I can tell.
> > 
> > The new definition has a static_assert() in it so it's enforced about
> > build time.
> 
> Yes, but that forces you to "know" to do that in the .c file.  How do
> you know to use this, and if you remove it or change it to
> container_of(), it works just fine again.
> 

I guess my use case is different from Gustavo's.  For him, using
container_of() is fine.  We probably don't even need an assert because
once you see a struct_group_tagged() then you know the order is important.

For me, it's code like I mentioned which does:

	p = container_of();
	if (IS_ERR(p))
		...

And I did see you suggest that people re-write that kind of code, but no
one is going to do that.  :P  People know that container_of() is just a
cast in that case.  It works fine.  It's just a bit ugly.

regards,
dan carpenter

