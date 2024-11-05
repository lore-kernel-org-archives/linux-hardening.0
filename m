Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222671D278B;
	Tue,  5 Nov 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805790; cv=none; b=FOaS0pnkkrhXYydY3bBDsmGxD3dOswY+5GmSDhuCKZNbk1GKjoI9gLXXxrq57TcBubImLt61QgbmGRvrlWF/WAAZI5WdkbS4YPNF6gQvYywrRhEnc7+IH9pFTDVWe1vTvJCCjhGd8etmD0sVORctCWwiQD2EMCG69flg34reWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805790; c=relaxed/simple;
	bh=5ae+p5+Ub1paM3FEnfKdtjlDbD//SfcTuWxbLk6HRog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHLFdpaAD4L7JPpV0Yn60rUBLVzfGRrYY3eLw//wmlwlm8naDSJz8Qz8jhJ+3xy4rndTO8Jy3ADF3AmIQEnLpY1yI2kEWeDZWTwpJr+7to35TuE+dr4/Cr66H+JPsskPqy7i9/S3IpEvn0L0D4wwkMav3IoN+XuQ89xTAP9h3wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gOtyZrwy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gOtyZrwy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9cFr9pH6MNW7EsyB1sOEQ8kmC8hKx31uNi0G3s6RSKw=; b=gOtyZrwyaVqH2m3//nCztQ3N45
	VBo3sG9gZHD6u2y71NhC5RT42D2lm4lvL6F9c6PgZyvYyv+aqQUoIyuqm1NZv15/WmGlSiLE+kQEF
	9KKh0djg4mDszpbn7hrSicTsrfJ/mPP2Gfn8m8uyXzZtAfmfC7iDjWtb56M1TqmwfCEQheju1gMuq
	hByY56R6TZYed42qVxWQaeefeA9eSSdYoQci7Qj1xjrIh4CoEAwi9MC0/RslY9kYHdqmRxKmi2n1E
	xLacu3UmzsBXHq7uqeFZVJq9hdim3u18Iz08qmWkMCPaSBZ2ORdmYW06a9Y1ab15zCqFfjM2K70t7
	fQMQ2M8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8HeM-0000000GqDi-3yXh;
	Tue, 05 Nov 2024 11:23:06 +0000
Date: Tue, 5 Nov 2024 03:23:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] freevxfs: Replace one-element array with flexible array
 member
Message-ID: <ZyoAGsCAdWrGMQoj@infradead.org>
References: <20241103121707.102838-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103121707.102838-3-thorsten.blum@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Nov 03, 2024 at 01:17:09PM +0100, Thorsten Blum wrote:
> Replace the deprecated one-element array with a modern flexible array
> member in the struct vxfs_dirblk.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Might be worth adding that nothing does a sizeof of the type or
variables of the type, so just hcanging it is fine.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Andrew, can you pick this up through -mm as there is no freevxfs tree?

