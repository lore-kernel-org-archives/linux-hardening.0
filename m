Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FED13B7A3;
	Wed, 20 Nov 2024 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128719; cv=none; b=YZPAy7VM9K8hpKm71S+RDq+0HjnkqGkXTY4wN9ibWZNVLXPtyVY+CDWA/gDHQq4+mBOWFBDTUn5/hZtbT+n8mcFqQrXAK0vETEwhhezH+YUJNNylEiirJU8aAsvRuY2BW6UVIpeltNc4bGnSiS5k3clA2SHZXDVEmaQOBSpmJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128719; c=relaxed/simple;
	bh=/gJ/eOmwINFIXuZDzdh0Yw7URgVvBBm+x4Yy3Pf59fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFBjNgD5axjWhLAzmO4rBNluoGDgZFiHzVBh6rVD6KmDXDMbA4HeJO7JcQYa4OsDTJ2r+M9MppVRuUU99Q1NdFLWu9br+NiuV11ijwooNQt8qAqjXCpT1l+qW16S1sobwIEhltTcT80NjIkbLHH71vWEX7UITlOVN9A8tGr4gFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Icc+yBF9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Icc+yBF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05EEC4CECD;
	Wed, 20 Nov 2024 18:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732128719;
	bh=/gJ/eOmwINFIXuZDzdh0Yw7URgVvBBm+x4Yy3Pf59fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Icc+yBF9iEVdOQHGaudcVAk6tV3qCNsbT0le0OrwwXdZU08uJYz7xYtx1+xYruhqY
	 wTH0BvMUge2wcxp629t8T8+GJV+LzNFJi6Q8UP7vD2eBQmFUgIgqfzT4QMi1v5TOeC
	 Y9joDRY5WzKlxyCnvA7R8Ki/8PWRHIVM/w8smzirYVXYlFYPVAkeSlgAMCD6nBDmtG
	 EeoeKRQaiq/UIpIE1rgqqvpQRXs2eCSS3yGK8jCTWEF9UA7+xJFW89QCNOtB7uSQAJ
	 xXgOnIccFtxDO2eJns/mHK5t0/BdLq4+pY3vKwgwsPDmidHQdVRGkT68FQJMnhZmyE
	 geFFOKGjAKkzA==
Date: Wed, 20 Nov 2024 11:51:57 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2 0/2] dmapool: Mitigate device-controllable mem.
 corruption
Message-ID: <Zz4vzSRcdjvWNIgK@kbusch-mbp>
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
 <Zz2r73CFtfuRmjup@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz2r73CFtfuRmjup@infradead.org>

On Wed, Nov 20, 2024 at 01:29:19AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 19, 2024 at 09:55:27PM +0100, Brian Johannesmeyer wrote:
> > **Performance**. I evaluated the patch set's performance by running the
> > `DMAPOOL_TEST` test with `DMAPOOL_DEBUG` enabled and with/without the
> > patches applied. Here is its output *without* the patches applied:

Could you rerun your tests without DMAPOOL_DEBUG enabled? That's the
more interesting kernel setup for performance comparisions.
