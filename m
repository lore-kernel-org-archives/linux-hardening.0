Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35C13D898;
	Tue, 23 Jul 2024 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767999; cv=none; b=TKmIk37nklbpEDfu+cMtIfzEqr6d2WuSQ5SvnwKZ5Qrjj4SJ/pG3a5fm3qbbzs5CIIcmsMCrFb6wxfLIP/bRN3X9mEotMw4tWPNdRbYJqQJKfUrVQEvKIa3wOseqv45LuwVIcQoAR/oIQ4ocKDXubXEWRzlb4/iaYBngnZJ6MEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767999; c=relaxed/simple;
	bh=nLXdX0nZvGK+p3et0VwEd4XC8lb38FAt3i9erKTxxS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRkppFn5WHIsqSDLcsRSbCP4XC2P2M/t9/9QLy2eKfaIiTwLGe7dlj2CFzDVuLncqsRbWQKiAR5XFZZr3bBW+mfypNEsoLdVxRAXsO9i0H0T+WpTxUp8Iic14MXRwof55XSp0gli0OEEJhNR+/Z1ZB78ThiHoVzx4farwyXEE/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMJJ7LXv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMJJ7LXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EEEC4AF09;
	Tue, 23 Jul 2024 20:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721767998;
	bh=nLXdX0nZvGK+p3et0VwEd4XC8lb38FAt3i9erKTxxS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMJJ7LXvzvRYLy62fiNDBZOb8ieaaDFgJ/ZQJL/cuyaVy3fhkBnxNLhr//6evZR4K
	 R3BxlJnACtSCyW8ybmfXUL7u74/tPkOEtJx64IUvbmugnMLJo10FvrFrlEHdRCXpcm
	 HkAhM0hktcnHb4JpqQInrfYT/UFNuVmfsCtsDaDxzdg1yax02U4WoHp0zrO2OhanPp
	 DA8A2Hdlb7VElZzcHDGC3UQvQf0jSgeAOfipiwEYlVnh1O9fP3YnqlYwYOA1xFwvUO
	 1RBfKxkKBcA+CsO9dmt0Zk/Gvtmhpodc92/wZqoY3aZL8d6ShRFbCJvnNj56HMKIlI
	 CLvhdKP4G18vw==
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: randstruct: Remove GCC 4.7 or newer requirement
Date: Tue, 23 Jul 2024 13:53:14 -0700
Message-Id: <172176799122.928945.8670359661478965472.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723165332.1947-1-thorsten.blum@toblux.com>
References: <20240723165332.1947-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 23 Jul 2024 18:53:31 +0200, Thorsten Blum wrote:
> Since the kernel currently requires GCC 5.1 as a minimum, remove the
> unnecessary GCC version >= 4.7 check.
> 
> 

Applied to for-linus/hardening, thanks!

[1/1] gcc-plugins: randstruct: Remove GCC 4.7 or newer requirement
      https://git.kernel.org/kees/c/f3e65520c0b7

Take care,

-- 
Kees Cook

