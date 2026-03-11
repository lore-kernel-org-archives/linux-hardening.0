Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F903DF00F
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242750; cv=none; b=Wc+7PRGtNSi5VBSGdeW8vNrGBBnIAks4Sj2lLvf6SeoAEaE+ojZUoUsJzVnneHeA/7z+npoopUZKObHHI6v8idmV0BuQnR5mO2NxCJ4UtFht+0VknYqSIY9tEcglNQ6+3j/Qbw93rb8Jg/CRDZuucyZ3RWaKh7rcG2lI4TPK9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242750; c=relaxed/simple;
	bh=r/GeP9Dh6SylYlLU3A4tb53hVlv7T086unpPbDste3U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y48gnbYbW2CDCSqmbLkCSEvsGuwqrfAvvezZ+E0+qOVXo7fi+MnZ5x3Ztl9cxu10WCtu6UbSG1FNtbRxKMJDNFy4+qZBmPK6NrHcAcJ3Pt1hgWdwDXWhYnAVkZMdBMvQCMrR00miBCOm0Nx/wf0el/a4Zdvn5/Txw1ZZ4+Sca4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XjQtqzZ1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XjQtqzZ1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C37101A2D92;
	Wed, 11 Mar 2026 15:25:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 98BD760004;
	Wed, 11 Mar 2026 15:25:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 206BF10369C28;
	Wed, 11 Mar 2026 16:25:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773242747; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qDYC6gMIjda1W+ekxn3OEPstANuf7EpN/Gc0f4A2X4U=;
	b=XjQtqzZ1LSJA7kNlU7eCeJq9Hz/u+dwBH9zx6BtAcZM6ZTW3FyGXwLButaUDqonLXAwRLY
	R1X5mRzI7vjwct/4BZc9MkDh7Wt3XW8chsZs/RgZTmUmwARtCXmSWmKIaFK51zb+cPwzVb
	lkBZo9JTJ7CZihcT6ZAR/KQOTF7iFg5IqiirfzGO7PFboZl/LsdIIrLYbLdgV8oTdC7z+1
	GatGDnshFUdbST0c0VIQ3hQooMVG1s3Q222Mb+dlYOm0fOb0DfZ/By0PgxkkXOwClJw0lG
	AtJ1/ChIeOOk/RucLM6wYENnbddhPynnnolBPTT/resmCnpmHHHdWpT5NGCfRw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: linux-mtd@lists.infradead.org, Rosen Penev <rosenp@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260305224410.14251-1-rosenp@gmail.com>
References: <20260305224410.14251-1-rosenp@gmail.com>
Subject: Re: [PATCHv2 0/2] mtd: concat: use flex array
Message-Id: <177324274595.685435.1398058459578427934.b4-ty@bootlin.com>
Date: Wed, 11 Mar 2026 16:25:45 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 05 Mar 2026 14:44:08 -0800, Rosen Penev wrote:
> Simplifies allocation. There may or may not be missing frees here. One
> allocation is simpler to reason about.
> 
> v2: fix mistake in counted_by in first commit directly.
> 
> Rosen Penev (2):
>   mtd: virt_concat: use single allocation for node
>   mtd: concat: replace alloc + calloc with 1 alloc
> 
> [...]

Applied to mtd/next, thanks!

[1/2] mtd: virt_concat: use single allocation for node
      commit: c685e6e8d88d544e8c4429b06c3e6795cbba32dd
[2/2] mtd: concat: replace alloc + calloc with 1 alloc
      commit: e19eaffc5213fdd6179e849d3032929fae0d8c2c

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

