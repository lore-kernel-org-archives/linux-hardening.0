Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0423A1B5
	for <linux-hardening@vger.kernel.org>; Mon, 13 Oct 2025 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356945; cv=none; b=CSM5PaZGLnpImZr69raGBH2RewCYIbKebZIR15lYImD90DqPvcPvyavqsPaQsOb+YMg/N9HnAs0/FjiFdqKb/oNuo7GPGzCeVCzI9eN2Zho9bcWmDqunWJK51Vi3TM0aE0qT5md6X1rEt/QtIq4iKmRh+nprMZIvWIxfBN1Atz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356945; c=relaxed/simple;
	bh=KHboIQv6refupr1G8jO/PDidwtSpxE+8ysLOORDABVQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pRvlTz3w/GKCQdLTxPPwCFR0SnK42DE2CnAAmS6/mGnv4bEBJLFvKZu4mkfBskJ16uV9FpMNeDw9YCJEqAgtaClNhRQdO5Ut94+2Dv8S2O3So/MN/SNe23Qj9a7JWaS1RSo/7mEuGt+orTstaWCSBhMm9BPIpkvwCMITrN47bYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iF1vJsmk; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iF1vJsmk"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760356937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHboIQv6refupr1G8jO/PDidwtSpxE+8ysLOORDABVQ=;
	b=iF1vJsmkXSUxP04f5R/FFr3Y/a8MD76OVbhONUWNa7ZNO6+0+b74fNBRuagGl3K1Pvahkr
	XTCT2IRMsqTEchHDlq4Bsd1OnOotdf18gikEaDlXqcGXTFCbDhlwNz25eG4YNOXLTsxF/L
	Pcf4TRi1LKOf14+w2ccQH+QkRmKrw5o=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2] drivers/xen/xenbus: Replace deprecated strcpy in
 xenbus_transaction_end
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20251013115129.30304-2-thorsten.blum@linux.dev>
Date: Mon, 13 Oct 2025 14:02:04 +0200
Cc: linux-hardening@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <48BBD43F-50F9-4521-B636-CAC71B8DE871@linux.dev>
References: <20251013115129.30304-2-thorsten.blum@linux.dev>
To: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jason Andryuk <jason.andryuk@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
X-Migadu-Flow: FLOW_OUT

On 13. Oct 2025, at 13:51, Thorsten Blum wrote:
> strcpy() is deprecated; inline the read-only string instead. Fix the
> function comment and use bool instead of int while we're at it.
>=20
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

I forgot to add:

Changes in v2:
- Use an inline ternary expression and remove 'char abortstr[2]' as
suggested by J=C3=BCrgen
- Link to v1: =
https://lore.kernel.org/lkml/20251012195514.39003-2-thorsten.blum@linux.de=
v/

