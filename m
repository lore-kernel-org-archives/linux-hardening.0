Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56145128372;
	Tue,  2 Jul 2024 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955072; cv=none; b=O6cjRDNRMkPFT/Ss54ztGvbTJ20wgxYwhWW6+TmOWjOTzVkqBvHSINc/KXEgXy15Hl2K+y5RUUF8+L4ALZ8bjIoM8C8AixPlkzXdr0i67HAaBtLbCaxUS0q/2RpK8gSRQ8uricOQQBdFIkRUST+nC7eQPIMFfHXT2VukZQxKy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955072; c=relaxed/simple;
	bh=3dFnD0nmao4vOQdfNPSf4nkQAWQwuwJRPpbqFjqEB+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OD5/pOdqPSmSgqwYZF0z/zhBlD+dW/6zldQDXvvspkjwD8TifDcIkJRvhWJKLDZyKlgXH7EPkU0AjFvfBgVKwrvDhNChMSfuX1/UAMKMG+kRvI4tW1LEgEsS8fFQAu44AsBYfZUOT5o2A93l1jaY1eHAZhnKbe030oR7FRybef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8Ni8lfj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8Ni8lfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F119BC116B1;
	Tue,  2 Jul 2024 21:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719955072;
	bh=3dFnD0nmao4vOQdfNPSf4nkQAWQwuwJRPpbqFjqEB+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8Ni8lfjzoRCT6caCwpGlxua84o4wfmSbVDMQPNrYytCL/RnVAEHOZrPpg9HasyqD
	 pcUCJO9rOYIqugZ6vXRWkSXgjSgFqTsMw66ohtAqcyjdq1Fd0P7hoIAacdyUsKIZS8
	 jwGBeooYhqpn8/aVRjMVyM4oGn+CO0TetMhhzhmFSinomqYNuM+oEgl/Xi+oj4NhZA
	 uRRF4yqSNV3WFhr3/VHvjaz6ka7Bwa96sRZ02PhxOFFG/MBU8TUwYSs9Hf6Trdj9CO
	 V5kAKIx+wgmTZoinqhexycpx1Pgn2aLaV1ikC6viM1gIO8CZjAmEW4euLCjmcFotx4
	 BhJp3t849vt+g==
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Remove duplicate included header file stringpool.h
Date: Tue,  2 Jul 2024 14:17:49 -0700
Message-Id: <171995506692.2090944.7529947170486711428.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240629233608.278028-2-thorsten.blum@toblux.com>
References: <20240629233608.278028-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 30 Jun 2024 01:36:09 +0200, Thorsten Blum wrote:
> The header file stringpool.h is included for GCC version >= 8 and then
> again for all versions.
> 
> Since the header file stringpool.h was added in GCC 4.9 and the kernel
> currently requires GCC 5.1 as a minimum, remove the conditional include.
> 
> Including the header file only once removes the following warning
> reported by make includecheck:
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] gcc-plugins: Remove duplicate included header file stringpool.h
      https://git.kernel.org/kees/c/3a8ccb6a6829

Take care,

-- 
Kees Cook

