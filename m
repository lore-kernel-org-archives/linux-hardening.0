Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FC62475CB
	for <linux-hardening@vger.kernel.org>; Wed, 15 Oct 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563259; cv=none; b=he+cZ2S2xgg8B20Otzsuwt4/UT54fWhTqidr99HCjy4cg2eeroIDHmSccg3jcQQteE/35U3PFZD2f6KI/56VFwq3/we5ClFq4tYjHTMpH/Cb2mQ2LgFuxrNfGwsAi0V3Y5XeRuG4lZSj9fBxi02BJHV32+H09xbb7nzWrcyxnYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563259; c=relaxed/simple;
	bh=RUEo91OD0bVkKNPgheh987AeBsPbqIyG2qPKmVLuPbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj+CqsBka+AAX+EZI3arm0dQgypoa2z/XX681weicfKnNhnzPHliJfA6OOxg8CQORm8HPnBa6DX3CxQGKH6xB4PG2bQsqJAGQed0Iqupfw0vC9CQH4NqH29tjZ0A1sqHoEu5sNayR8OORMBdMgAFRBJtT3qFOmHKzrPSN0+5Efc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fA8KZN+2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA8KZN+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0837FC4CEF8;
	Wed, 15 Oct 2025 21:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760563259;
	bh=RUEo91OD0bVkKNPgheh987AeBsPbqIyG2qPKmVLuPbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fA8KZN+2TvTOhQRrjdHZVvc+IczXHA7TDFc2dLuqsKr4rZRf5jHzYhRJl2D5G83nt
	 BMsg8WEpvvS3RHpUv7kwWJx4S+LO4naHrSHc+ngJ5wB1FTua97fbDsbxvGyToGBNIt
	 CP4TyScVGgPZ6eZG/EbNPrli6iK39FBS7pT3vw0Wd999u8mtorOtD82WhIrvSLVodm
	 qzJrjp+/VxygVrUHokNfmY2+XqmVF1IXY6YVdKAYWGv3FhGicxaXqh5yzCRWWmDHSv
	 Lc04GYKhI6apsUngGBsiRnbe7hbReFJnn5TSldqFYHE6BDs88q7poQPnv+MKnvRb1f
	 CzwTMRLO6Vgsg==
Date: Wed, 15 Oct 2025 14:20:58 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Claudiu Zissulescu-Ianculescu <claudiu.zissulescu-ianculescu@oracle.com>,
	Claudiu Zissulescu <claziss@gmail.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] arc: Add const attribute support for mathematical ARC
 builtins
Message-ID: <202510151420.340ED16A9@keescook>
References: <20250826042212.work.202-kees@kernel.org>
 <D882BBEB-31E0-48A9-A595-BC5B47EE4899@oracle.com>
 <d146466d-e5b6-450d-8b6c-c27ecc87b310@oracle.com>
 <7DFF075D-A922-4170-9199-0B1B477D79F3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7DFF075D-A922-4170-9199-0B1B477D79F3@oracle.com>

On Wed, Oct 15, 2025 at 06:09:51PM +0000, Qing Zhao wrote:
> Just want to make sure: have you done regression testing for this patch on a ARC machine already?

I have no such real hardware, but I've done Linux kernel builds with the
resulting GCC ARC cross-compiler.

-- 
Kees Cook
