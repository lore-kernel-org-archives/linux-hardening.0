Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772612CDAE
	for <linux-hardening@vger.kernel.org>; Thu,  8 Aug 2024 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723139851; cv=none; b=tyxIGJgZaHS7qJqfXDEpTZB9sqLuvkqbCTLnVXY5u4RpE43WA+MQ0gc9VOZNj8Jun0hhVdj1MreEQCQsX86m/B6pTqJdpS5c3cP2efO/qqZOw10sznydSos/unf39aBMcItye0AeDB+FOoTqfIFXS5KuHYoOn4rbcOfj2BvAT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723139851; c=relaxed/simple;
	bh=Lm2z/sXbJxVP14ghk/42L2QIkHi5+o588+d6iLbiWpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYRK+VK1/JF4JenwY7DQMgIOtoisKGYXpKGsae02+QIpDkE/R8S6c92eN2BRAGIHcSKvKEUS8cZM983NqWnyjfM2Ho9+4U/2cdlaIs+Grf7E1nNPTWuq1+a02rkMlggdZHnRxHZjrJuofh6YjnRx6TcB4t9IsYa1tHaVGxaVpys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmOp97Rv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmOp97Rv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CCDC32782;
	Thu,  8 Aug 2024 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723139850;
	bh=Lm2z/sXbJxVP14ghk/42L2QIkHi5+o588+d6iLbiWpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gmOp97RviXqNZWsc9nmjbhJB8O7uSKgWJjhGAYCZ0kCOQWFIHvKOCTJ6CGBdlB5hp
	 qo41RiERi0FOlH9UEqsg1ffq8hZ/7Xzioi8/LYXzoqsZiQJb+csTL9/TVMvScjUBc8
	 Srlk1BhbAbBAiJCrZuF1nGV0jap/+QuHf0Go6K8q7AIFqaP9h+1DmvGCmBSOG1EGxP
	 7hX6RK6Cwf9T/g5rgtS3SOEUGfOIHdAkja91/0EH2AE7NhEgktOAtRS5ey2/ZS/s/I
	 9fcupeJFvDAGHscI6qv1IlQLjtFyaBrOL5zdBi7kJ6a2RCuj6rncRrn2vYDMLCw1Qv
	 D9OJUWSYqOfgA==
Date: Thu, 8 Aug 2024 10:57:29 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/string_choices: Add str_up_down() helper
Message-ID: <202408081055.60B7E5935@keescook>
References: <20240725101841.574-1-michal.wajdeczko@intel.com>
 <ZrSLdCwtZA-iB1L-@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrSLdCwtZA-iB1L-@smile.fi.intel.com>

On Thu, Aug 08, 2024 at 12:10:12PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 25, 2024 at 12:18:40PM +0200, Michal Wajdeczko wrote:
> > Add str_up_down() helper to return "up" or "down" string literal.
> 
> ...
> 
> > +static inline const char *str_up_down(bool v)
> > +{
> > +	return v ? "up" : "down";
> > +}
> 
> Can you please add a respective macro for str_down_up() as it's done for (some)
> others?

e.g.

#define str_down_up(v)	str_up_down(!(v))

-- 
Kees Cook
