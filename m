Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8F281526;
	Thu,  8 May 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722661; cv=none; b=OztYGOXPwsB8NejFALceTmkdUjoVHMv+SKiGMXS+Np2ADazPvGINzZodxm/gTHupeWC5XEeolskkSyb7lEg0k4glqFo9BJC41KogWAz5wD6P+392GpMEMgik2TioTUOBwJATOAX8fiUQDZNoaa3Xrfh6PLyAqzE+7JzMe6T618c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722661; c=relaxed/simple;
	bh=1p+exU6uZIQgSAmt8Mh4//0GdTSamVvFDXNvzVOgZYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyddkES+GctBDhk0Xm3SpYdjQoRIKcoITuer8q/fQdwU6s/4lYrg1OoF55JESNgJRHaGTgtTo2Sj92WrthWp1ke4xhdmvUMVFpMsjfaJ8koK/Fj4MRVrF8Sy9c5/vJqXHs55N4DjwlsFQjlwjCWFleOE9KiU8oeeHlRvL5vZS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rcb5qvyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rcb5qvyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFDDC4CEE7;
	Thu,  8 May 2025 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746722659;
	bh=1p+exU6uZIQgSAmt8Mh4//0GdTSamVvFDXNvzVOgZYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rcb5qvyJwC6kQY1cSiDsKDd0AghXmtIRGYxnEwL6Q31wD19tKLd5Yxj7AgES7BXB9
	 VApVTWKqQlReDrvQZuczqZV7pifqSgwm9r4a2eyHQZbYLxjwpIBGE4SnTyzgxvi9n8
	 V8Fby2R7uus+6JZY3bcZD9Gk/Y6C0X3hMm86o5PSF22viOhUIn2JhFQ3IaMO53FnVg
	 2FQx8U1YvpUCWWl8ZuqvPI2vjr4Z6KGs8NTWLvEQZzYn22mhJBERObXW7X2VBCRrXk
	 x7WeOsO7o9RisW8xd/Ipcav2Cogk71IECxDhNh6g/eYWT3R7xMAVfNQAa5H+N3cnKh
	 x5ZtUyDyGepqQ==
From: Kees Cook <kees@kernel.org>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/zone: rewrite some comments for better understanding
Date: Thu,  8 May 2025 09:44:15 -0700
Message-Id: <174672265398.3028062.4801516340901823797.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117084228.3218024-1-eugen.hristev@linaro.org>
References: <20250117084228.3218024-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 17 Jan 2025 10:42:28 +0200, Eugen Hristev wrote:
> Rewrite some comments to make it more clear and easier to understand.
> 
> 

Applied to for-next/pstore, thanks!

[1/1] pstore/zone: rewrite some comments for better understanding
      https://git.kernel.org/kees/c/cd5761f6917d

Take care,

-- 
Kees Cook

