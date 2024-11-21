Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F213A250;
	Thu, 21 Nov 2024 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212378; cv=none; b=dlF0N6qriQ6ro+M1lGgI2PK/CGmW82K76pOemP+4EmwIpE3AdQccK9sOOcEg9wfuIL6LqlOqWXRIhjxqCGjBOymMoGvg/CNlggPsYXy48ymBlnKCKl1Faaai3Ykr09lgsQposMqtOEjLzJB4LGuyNHbwOibVPKLN47wir74Ragw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212378; c=relaxed/simple;
	bh=CoRC65t5X+4YtODRNdzo14wAEbCnOUtoU7iP3Az4Bwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srsVQd1dWaJeDZ5T3jAxwC5jNXlwqiL9yDRnNG7ya14dQRYF30SitWKHGaFRyjm49kjgRsHIjrWKCVbT/IhVmmBzOYit0muScZ6VHtNsVvy9uY+PaLLhKfOX6hhBji3ByOJICUZrFRzTGl/SPrSkMAxmaDSeGs1ZNmuROqjgup8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOCtBxiA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOCtBxiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B73C4CECC;
	Thu, 21 Nov 2024 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732212378;
	bh=CoRC65t5X+4YtODRNdzo14wAEbCnOUtoU7iP3Az4Bwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOCtBxiAtXiI5NSxPAWT1z1cuvghWic2v66iIRwReSVnhMIM5cA9bVYQ1cB+CD06H
	 gItBBnjEQ2mqL0ULwmA6Ynwu5UMI90sfWG2RW9qlaZ/JHBFzpVhfA99dlpsXgatwHZ
	 lMKxODGc34GUpFgLqtKyNfTVDWaxndRjKtBr+9R7TVKe9QfzsD6xngXHp9NBB4T6jc
	 eSGyuC/dz9Ex0xZYOQ2fs25++CIvHzYutLBundzXzZEeLMEDeV27grG1BEn5R554aP
	 xLNHTTpChH/8SnpNl6Y8NQDow+aq1i04Q+5eNdRvztn1H0SzG6Et+LJzlTbg7/VXj8
	 D0l1+jhVf6xJw==
Date: Thu, 21 Nov 2024 11:06:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2 0/2] dmapool: Mitigate device-controllable mem.
 corruption
Message-ID: <Zz92l2gxYtK4SUC_@kbusch-mbp.dhcp.thefacebook.com>
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
 <Zz2r73CFtfuRmjup@infradead.org>
 <Zz4vzSRcdjvWNIgK@kbusch-mbp>
 <CAOZ5it1v3zxiavxctm-d32bT9aO701Os1-EnEeG0KCUhBPLMnw@mail.gmail.com>
 <Zz6q85eMTko7P-Y3@kbusch-mbp>
 <CAOZ5it3xiMwD4_HsgXR_7-ERTzoS+FG3W5Og4sKtgthFA7HsVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOZ5it3xiMwD4_HsgXR_7-ERTzoS+FG3W5Og4sKtgthFA7HsVQ@mail.gmail.com>

On Thu, Nov 21, 2024 at 10:31:11AM -0700, Brian Johannesmeyer wrote:
> **With the submitted patches applied AND using a maple tree to improve
> the performance of vaddr-to-block translations:**

If you have the time, could you compare with using xarray instead?
