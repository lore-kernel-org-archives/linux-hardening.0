Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4B21B192;
	Sun, 27 Sep 2026 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790473775; cv=none; b=ktT4f+MfA9fEKVReP5DMaQED9JTXbt/omC1yq54m4FwLyZAXE8fUpXt91zYw06FlIfZk9Fx28JvK7pMWVdx3ZS0oLt4zpkprS6sl9iIYnxPi5+DNhxdVnnyxRvNZgd11S9cjgjIxTP118fsseQM0h+CTbqDKywmH/hs51qQXrhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790473775; c=relaxed/simple;
	bh=J2EjSK4GYCP9UonLY0FnYK7LFQsBJBbcc8GokYxw6uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm+qKB+ap63NpNu0uXMFPyavtj0RVgAQG/pI6bwT89JWjONWIQV9WUB0wQKeiwWEPEQgek7zOKCkOcCgMue1MBtvNjD11IKJ5/QSMSVT3NXUuk8ZM7W8bCsfen6vvmdzgRoVsZKIB9wBIBK5BJvqAgHLonqwlGR4O8xQ0XoB5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=LzPL2/+n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tHNWO0xW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="LzPL2/+n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tHNWO0xW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 979E61D00073;
	Sat, 26 Sep 2026 21:49:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 26 Sep 2026 21:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790473771; x=
	1790560171; bh=rA4LSxCVQPuct0fsk7/K44YfG8wp4yBOm4ZEsSk0LG4=; b=L
	zPL2/+nSqmacqfU+pP+weBayNYxcQQQD1iomlGUghRM5AU/ZrSjeeOb9twWQ5JiB
	qBvI3GICXvG7fvSgwWJMO5n6HcfEuYyiy22/RJwnrDd/JvlaytqIjvsUeq6M+x1C
	Dq5EVl7t9GeRkipjQ2Z1BySsiMv03gh57eJ2k/vkgX5lqYKfCccRN4jG591/T2Ig
	UNZTfjjUmjhtJReZKvwtCcrb/G71RfKhEJEomecv/2mdPXgU0Y/W7WBwkvMpXqQy
	tvtCXIxix2mTmyInQgWU3u8+y1EOjEq1tB2wxBpLa0IVEl/iSoNAOZEt9Jf3tp6o
	e8xptOFoWNyN30m+rqKdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790473771; x=1790560171; bh=rA4LSxCVQPuct0fsk7/K44YfG8wp4yBOm4Z
	EsSk0LG4=; b=tHNWO0xWjSKY+9dPihBJx55Xt8twJ3R5cZ05lPavuVzgPJM3mCK
	MR4liOHINL9suYu44+FayyblqX936PKelPaPZZCGfuETkhoyKSWGUecpVq/KZp0k
	IaZDmvutw5giXoQRROZzLw0GIR0VCbk8/f4tYa+zTTpTT0MbAcq5QNW1LQCQoT/5
	/JMk/xd2CKflOFt+3Aywej/wWFup/YTqxK6QSxK7fvugYT4b8xIbBi9X6H8yF9fL
	9bLoArh8k0ZBGXf0cAATf6MGHaeEoXWuS+HX7DSqLsvv01XomQGVkMxYjN4us7SN
	WWNJbm/5luRu6FNAXzPQfSKl5szaMYmH2Iw==
X-ME-Sender: <xms:K3a4amjL98eNNELjka8IFLDoJ9htQbnltsyuEepuvOk9l2QHorrikg>
    <xme:K3a4ai12UjbL-kP7XJxYxk8vq5mX04icJnLaTprvHhVkW91QmCLsz2SddduGbrnug
    _CysXyGQgVrkzI8Zw6EltWVDcRZCozRUEQIQLIBezPd6PJ3AMlLG9cF>
X-ME-Received: <xmr:K3a4apf4FfdEV1LuCDlYPCxTdFcte-OTDJaU6aTQV7pgQOc0dr7lTCadVtGUedNFyNwir6m_C8NNIznUoCpic0s_4dHVcg>
X-ME-Proxy-Cause: dmFkZTFnQ57NGncRnmBI3BkhWhFtNBO/q5DQ0aOxPo0phctjA38R7yQSje04TRLCD1R0U5
    a/VQiP7RnC+3OtH4iKh9eG4HRKaiSU7kvKYUSexmV5j6C+UmXZ+222uU/KOONHUxfEm4k1
    JPHJCU030jxTnprLucdt1VS1zMUCYRmU6YziR6+ytQc/WT47ZQJdU8rZQ5mD+2gu0NDRJn
    OeMKBBF52j7/zCEdJJQ7oXXhquV0O5Ug/o4RgTKyn4FEX/AODMiYEtYZtJP6syB5vbPBzR
    q1fycm03968BX4vO5gwdKEEvZpCRObuD74E7Na8anzkSKRFV16tkbyegzKM7KM9PdfeoJc
    orLdy3OCW6bKuAMuub3C5CpFCmm16HPEMto7phbNHBwLoLruca1/zEFEfXpROKbD2YDE4C
    iYEvOJCamCthomtncHUrOQppbs/Q/Rt9ZHrHZPCUu5enHEvG304+LUymaW5g0CL3fXll8s
    A6EF4cTP/h4/Uf4aGTdeA1GCuuGVCkWxjzfXBv7cfAtdeeOZQQWWfPDWqCR/91n1Q5oeGt
    U9MEFMnfsSjc7iJPMnRZ1LiE8YNqavgy18TJcBYONaeRu91vqmPSP6PWwqoLP5qZmaBsbk
    fSQKDgAX2Wfh/xNhrGe0MG+/zPkjZltp3oBb4xZ0vO2m9/5PAs2tJiKhxg3A
X-ME-Proxy: <xmx:K3a4aoy_lEFbaqrEjBUR-Yi-pOAS5GsMzdFDFce27Q_6LMhbOB8TSw>
    <xmx:K3a4ahztB9RLNqdtMwYr36rzB_5gK1WlLbmrC_wRkM4tzxU9I-9_SQ>
    <xmx:K3a4apbuNW9Gkb4nlF7fVbKnd9NxZGyZUiAaUV4eN9fMbH3QZzr40w>
    <xmx:K3a4aq1nMp7hOamoF8wtHjDgELx-nJ4V3rGRyeEFHpsKOa10a3vrhA>
    <xmx:K3a4anFkfq2WxUmjeYLSQR1YD9UPOkDVBFxz2SVGDuY4vJkDeqjRmpit>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Sep 2026 21:49:28 -0400 (EDT)
Date: Sun, 27 Sep 2026 10:49:26 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	codemender-patching+linux@google.com
Subject: Re: [PATCH] firewire: core: add __counted_by_ptr attribute to struct
 fw_device
Message-ID: <20260927014926.GC9201@sakamocchi.jp>
Mail-Followup-To: Bill Wendling <morbo@google.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	codemender-patching+linux@google.com
References: <20260925212552.125652-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925212552.125652-1-morbo@google.com>

On Fri, Sep 25, 2026 at 09:25:52PM +0000, Bill Wendling wrote:
> The GCC and Clang attribute '__counted_by_ptr' associates a pointer
> field with an integer field holding its element count. This enables
> runtime bounds checking by KASAN and UBSAN to prevent out-of-bounds
> accesses to the pointer.
> 
> In 'struct fw_device' (defined in 'include/linux/firewire.h'), the
> field 'config_rom' is a pointer to the device's Configuration ROM data,
> and its associated element count is stored in 'config_rom_length'.
> 
> Additionally, update the existing KUnit test in
> 'drivers/firewire/device-attribute-test.c' where 'config_rom_length'
> was incorrectly initialized with the byte size
> ('sizeof(simple_avc_config_rom)') instead of the element count
> ('ARRAY_SIZE(simple_avc_config_rom)'). This ensures the
> '__counted_by_ptr' bounds-checking annotation does not trigger any
> false-positive panics or compile/runtime checks.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  drivers/firewire/device-attribute-test.c | 4 ++--
>  include/linux/firewire.h                 | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Thank you to correct the KUnit tests as well. Applied to for-next branch.


Thanks

Takashi Sakamoto
