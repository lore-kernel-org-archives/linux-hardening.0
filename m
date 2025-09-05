Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54A1D6187
	for <linux-hardening@vger.kernel.org>; Fri,  5 Sep 2025 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757034550; cv=none; b=HJQnF85RVpanw1FGqB+XiY0tUTSlYIlIRW4B6YfAxcA3V/uiT9ZPmNn6AL//4qfKmSFS81QLENHkgTBJQCu2tT2EIzripDPYgrgZkKJWLM1bwXADtBrlRV2gCvTSofK+FtVBq5a7E/ykkiywjQQpOuB0HXwCeepJ2aKPqsEiCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757034550; c=relaxed/simple;
	bh=3G0O8uwq0/lMOK2F8gxjQTbTNvdSeqZBOubGPOeA5T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVGVoXaxDuNf5tz23d8n2eMQ2CKD3lSUxUvT8kuDqKV4ihmmwMRMicTj/dsrSnOOw4ciNH04WiwaH6IQglUZsASRub9H2jsDOZi270rUpGwy6Cwwa/ULfBa0ceTMFq6S6BhPxjR+gJ4V1TDXr7w+FTiaj4wapegVE1ocNyc1PSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq5Bheai; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq5Bheai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D607C4CEF0;
	Fri,  5 Sep 2025 01:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757034549;
	bh=3G0O8uwq0/lMOK2F8gxjQTbTNvdSeqZBOubGPOeA5T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dq5Bheaiyi4YPQeZCJQJ+oMT2CR0zT7a5IRNoMSZtqGg0o2tUX3vF7/OIz00V/g2N
	 2mqLb0RmYQx/jyYidG82wHFgMXwEUOimRb2FFfyJ5TX/3JMFKckifThWRTc8rzT2zJ
	 5r2+HHUo7cuR9yz3zwNq9VXb2hkfXak8Wy14sPbyTg5KJwdE5jPIoHVoPLKgW7rLf2
	 yPKv2ogxTRn+ItenfhfGiT3qGT7uZAgyvZzdOKvv20x65HR5htrKKRNhZ5luvmpWzh
	 Jsx+0wROUfXqmJLLUlpL1xpHL4coeDnBo+If/KwRT+k9I1LfFVErZTLCXWPNs4pxmb
	 9zh0Bar0SCoVw==
Date: Thu, 4 Sep 2025 18:09:09 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/7] mangle: Introduce C typeinfo mangling API
Message-ID: <202509041805.5C660B7B70@keescook>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-1-kees@kernel.org>
 <CALvbMcADtEib6D05aC0XoDwOsEG-wHDh7M9TPUSXmG0s17hX_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcADtEib6D05aC0XoDwOsEG-wHDh7M9TPUSXmG0s17hX_w@mail.gmail.com>

On Thu, Sep 04, 2025 at 05:50:45PM -0700, Andrew Pinski wrote:
> On Thu, Sep 4, 2025 at 5:27 PM Kees Cook <kees@kernel.org> wrote:
> > +
> > +  /* Unknown builtin type - this should never happen in a well-formed C program.  */
> > +  debug_tree (type);
> > +  internal_error ("mangle: Unknown builtin type in function %qD - please report this as a bug",
> > +                  current_function_context);
> 
> This should NOT be internal_error but rather sorry.

Ah, heh. I switched to internal_error because you'd suggested it in
the last version. Maybe I misunderstood where I should be using sorry vs
internal_error.

> > +       if (!name && !TYPE_NAME (type))
> > +         {
> > +           static char anon_name[128];
> 
> I am not a fan of a static variable here. Why not just a stack variable?

Oh, whoops. I will fix that.

> > +         {
> > +           /* Always show diagnostic information for missing struct names.  */
> > +           debug_tree (type);
> > +           internal_error ("mangle: Missing case in struct name extraction - please report this as a bug");
> 
> Again sorry rather than internal_error.
> 
> I still think it would be better if the hashing and mangling be one
> step rather than 2 separate steps.
> Especially since this is only used for the hashing and will most
> likely only used there ever.

In this version the hashing happens immediately. No full string is built
unless the dumpfile is enabled.

-Kees

-- 
Kees Cook
