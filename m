Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE41A8F84;
	Thu,  3 Sep 2026 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788406762; cv=none; b=XciFD7p7hx4bTixpOcLaDJMLY7xLVwfByatTNZxCPn62Y92WIYlxKmn5G9dAdt9pHlUYxurxR6Wriq+31/qL9Lcqh7Db9b5Udd+sFlPUMAnCDTWot51a4X81YX2qxTKggnY5XrAwHXcMoEIMJ4WCN5JdGJ9Eibv1pUbtXnKAk+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788406762; c=relaxed/simple;
	bh=/PWU/tsWkmuN9nY21zSa08TegzVVCYJ/SGFMG7qM9Kk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AI4PlU4QDDlNJEp9bmKZXJ7ZVtzcnCYTuqbmsivQP0dam587EymWqSuYawZki0q6d0qcQQPE711So9rmtrMvxjLEUWFeCMoTL6pj0C6V6glEdnkN7RkibXUHkVJWljfns+sPvctzTMXXTYpRXPcrJNwAKdUxSX/OCtqsvptmmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLONVf+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLONVf+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F591F000E9;
	Thu,  3 Sep 2026 03:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788406761;
	bh=il3+9SnNHXN3k7XUpAO/4rCSOayBxmPeo3Wv4RVoeTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mLONVf+Fwx/Di5maAHIRmGqS6uFPu5+P9e68ZcIe4L7r+Zhv2N8BdCRd3OtWtlmUS
	 bx4oLoYwauQd6xykl5CUhHmB6mbYPWqzaJ4sQTEEpnQbzUj5u9QHCW0FqacZqV0/mL
	 ztMVCan9JAR+Hvk9cSdI9FSz1zWbdJvrVEyvymzaEvxkPke3G71SIgevN1URIb6vmA
	 KY/Z51wF5i+SGy6T54Ty925GW+FFDyzJouF3/8TXrDYlxDMW+Efeuaq2MyeExEV+wn
	 wmWJnR4ZIFPvgKJUq1zjyyZ6UMlpIIVOSIny4nxy1p1DBfFj8h22AmybHVQ5JaScl0
	 8QCjOyb+u5neA==
From: Kees Cook <kees@kernel.org>
To: Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KMSAN: fix memset() when using fortify-source, again
Date: Wed,  2 Sep 2026 20:39:17 -0700
Message-Id: <178840674549.2647132.11479583220926959631.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618142951.1739694-1-arnd@kernel.org>
References: <20260618142951.1739694-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Jun 2026 16:29:43 +0200, Arnd Bergmann wrote:
> Both kmsan and fortify-source replace the memset function. When both
> are enabled at the same time, the kmsan version gets used, which triggers
> a warning about fortify-source being nonfunctional:
> 
> warning: unsafe memset() usage lacked '__write_overflow' symbol in /home/arnd/arm-soc/lib/test_fortify/write_overflow-memset.c
> warning: unsafe memset() usage lacked '__write_overflow_field' symbol in /home/arnd/arm-soc/lib/test_fortify/write_overflow_field-memset.c
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] KMSAN: fix memset() when using fortify-source, again
      https://git.kernel.org/kees/c/ff936b726c98

Take care,

-- 
Kees Cook

