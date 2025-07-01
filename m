Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBE27B4FC;
	Tue,  1 Jul 2025 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387277; cv=none; b=Yvc7cfj5FbSEzFLiRcH40nsJlI4u89NiCpxCgd+Ou8CTRa/QseM2z73flY/EkOIAp4i8ELZ44fe65lglFPL5YpM9ejABr1B0Wv/30XL5kvT+VCIrxibTE9pl/q/wTR49B6ejuwtuvsrOjDOU9+7tFF5OVGQMPe237xohTD5p+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387277; c=relaxed/simple;
	bh=AMho8//COHVPW9204pth4Xq9HE4fS4veSK8IvjlcpF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIoxUqMLUaPP5PbE4eOUgZqlnLo4PH+2AJjHLwoI4RvtNzVAWIzLxYjlBmikWTDEO1zctsZtOtsVa2RjQykVLSVF0Ph6Oz0m3khOfuZLT+ihXq135IHODWeFuMmOFmcvcUlCN00SAbHAnJTAAo4G3Qat/zGaJbqqvIPa+goLPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCW0P19a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCW0P19a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43875C4CEEB;
	Tue,  1 Jul 2025 16:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751387277;
	bh=AMho8//COHVPW9204pth4Xq9HE4fS4veSK8IvjlcpF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCW0P19aN2bfnNcyssfEdEuMzmJ/RfKGTOmjnNMoRbd5JF2tdg2XyLpI5VQor6a3+
	 XQszQz2pXoSMdTbRAPhS8sIL9sTP+zZjBxm1JAc+i4uZ9/RKZZ42FqtT1Xew5c6jIi
	 +zv5JwBJ4dy8NKH1bI5hwx2p0cSN9R2FyXJhYttKiDgAnRoMMMeWewh59sqan8Ls1D
	 iXbhXvFEWm5rklkkvba8AZmo/mcnOGqiSqCOmA7Bsm+tzlw7j37MlXAt3945gIpKZg
	 kXn7sL9xo46fJ5TamZWBOTiLcU0QiSOSbX0GnRHqZcRkOGtWZPr61XTGXmnvUkrvmr
	 AoalI0kmjuYdA==
Date: Tue, 1 Jul 2025 09:27:56 -0700
From: Kees Cook <kees@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Jannik =?iso-8859-1?Q?Gl=FCckert?= <jannik.glueckert@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-hardening@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] kunit/fortify: Add back "volatile" for sizeof() constants
Message-ID: <202507010926.1650356E@keescook>
References: <20250628234034.work.800-kees@kernel.org>
 <CAG48ez0n1E0iuOxPe=jq4MuuP3w2wMSNixmfNmBbB89jyJBSbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0n1E0iuOxPe=jq4MuuP3w2wMSNixmfNmBbB89jyJBSbA@mail.gmail.com>

On Tue, Jul 01, 2025 at 03:41:35PM +0200, Jann Horn wrote:
> On Sun, Jun 29, 2025 at 1:40 AM Kees Cook <kees@kernel.org> wrote:
> > It seems the Clang can see through OPTIMIZER_HIDE_VAR when the constant
> > is coming from sizeof.
> 
> Wait, what? That sounds extremely implausible/broken to me.
> 
> https://godbolt.org/z/ndeP5chcb also suggests that clang does not
> generally "see through OPTIMIZER_HIDE_VAR when the constant is coming
> from sizeof".

I agree -- something is very unstable about this case, and it's been
very frustrating to pin down.

> Do you have a minimal reproducer of what you're talking about?

I have not had the time to minimize it, no.

-Kees

-- 
Kees Cook
