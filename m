Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161012F7AD2;
	Sat,  5 Sep 2026 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569335; cv=none; b=GvWd4zssiO0PrEaSphHroUSb0vXSK21aDH+i445JY6U/hcrmVXGtjUZvYjh/wiDP/PmNqgCTqPJfWpjjGBIL/6iFQDwJbfHSDo6Fn0HkMdv8lnpYeHIGbDFvZr3ta7FBXQ+C8KedJySJzCtsbh34M/tX5UswXxHqBqZ+ikk9WHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569335; c=relaxed/simple;
	bh=ieUxajQo8F/H5On/TfCtxOvpIDs2vLDZvcKOlTNIBis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKoMm4xwnMDch0e/rJSTYJOX0Wele6/HQWZyU1k70fnT6f9TGOyO129WcjTYXPGG3HJ4zll0Zd+/rQ4Z/8EDYBKJHN+hXWx8rg3trJ99O1Hgh6fK24rclKUae+rlvadeOfLstp5/lh+DHdLDerDeMR2UPsfrnECgrZUl5RUbURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVqYZVir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVqYZVir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FFA1F00A3D;
	Sat,  5 Sep 2026 00:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788569331;
	bh=bz41QAEg7cxLewfi1vUQSONOCuun/1phJ3ccrrG9tXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QVqYZVird6cP7RmSCEi7c2BNv1vik0g7viueBlTPZIkzSLLC5UEMI8OoPv4djAw6z
	 3zbHo/A5KFzBpb4awLzEmsZFNmeon6P5dvsedPM7vdIxAWIsE2iZN+e4L4J6ySFm4w
	 j1tNoZcrbxkcgs4UdnHzv4HdvgYhH9cXDw/oU7NklMhVHb5os81W/hP31y8F9/4ugQ
	 EtbmUSajDm/36Fqu0WSljLafPSblPgnjTJFsfTWCH+n3iv1giDc7QmctgszVuxVmXF
	 5e39WLpM0baYYsdDHOmRiKg18Jhe1Z7MhkpBHHSzHXLgJeQ/dl/S4APbFCGciCgEB1
	 6UH+0sVmiYuPA==
Date: Fri, 4 Sep 2026 17:48:51 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] randstruct: report bad casts as warnings rather than
 notes
Message-ID: <202609041748.010B5CA1@keescook>
References: <20260903232428.i.323-kees@kernel.org>
 <20260903232438.60394-2-kees@kernel.org>
 <CAGG=3QUHtqFVCEcnxXO9fan_RBT_jjWtBbA8ECpQeiC1dKMnvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QUHtqFVCEcnxXO9fan_RBT_jjWtBbA8ECpQeiC1dKMnvg@mail.gmail.com>

On Fri, Sep 04, 2026 at 11:14:19AM -0700, Bill Wendling wrote:
> Why not make this an error instead of a warning?

I guess I was thinking of moving from "invisible note" to "visible
warning", but I'd agree: better to just match Clang on this. I'll send a
v2.

-- 
Kees Cook
