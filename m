Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EAE2F44;
	Wed,  6 Nov 2024 05:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730870719; cv=none; b=YnsMxd6swTPlNR75x24XBcf3st3aw0o4nud9WmztpeZwQxZ9byL30aan8bgLNlqxqLcNY5w02cVnabX+LNtABaV2n+SgHbo6KAqafm12N6w9v7cSS4bLkL8m+p298coS7m6ZwOgtOY+mTj5b8IUedXgRS359o+nIldDwZT1Wf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730870719; c=relaxed/simple;
	bh=l0aGCwkVhm1jLImaX/Bd/NxYLern8Z/9r21JjXpennI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3ESYi9NVe+C19qbK6H9s3AJMlzKJrz5HAK/fXO4vEy0C9gYx4g0HY9jThCGgSbDS5lVVbFAZrfQnza0+0UxPmt8bgtHCOzmx3yM2uz0iikY9KGJpQexRDw4aVEN+u2YR5lBDilhIZL16llXfI+gW2sQQLDijAaQvfqhpTuIUC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wgnbkvF3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wgnbkvF3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HsyTQA9Pe8F79mmQyU7MaE/8f1BJOvN5kT0VZS6VCGA=; b=wgnbkvF3yxAvCLCGvbXk2mQOqV
	JjL9JlSO4IjIP0uWRg75mspI5KA3Z0p8SSYe1XpO02s44ZBT7IZccDbJOTKgV+0pHTDxP4Vvusq88
	DeluJnb8oewwqq8utMUQgtPmr1+eQ57NJ1/KZLe7wzqhi9G7Ba/d/qjgJKnsuI3uzbla12qTg1csh
	Rq4silM29FFAHPfQGkLqVZJJHkUziVMbXrg1dry9w2y0P3PXMDdB0LuWEJuR9UhUmjnVOdfENGjLn
	4XsnQMKfzqT6CpY4JRoOXgP4rMFlrEIpHOETEMXMBPcdgffSZYwRxO6pNMeEtk1F6UxYAvNUw6h0j
	q0uT+Ppg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YXc-00000001rcB-1vu9;
	Wed, 06 Nov 2024 05:25:16 +0000
Date: Tue, 5 Nov 2024 21:25:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] freevxfs: Replace one-element array with flexible array
 member
Message-ID: <Zyr9vNpKpJWlD_wf@infradead.org>
References: <20241103121707.102838-3-thorsten.blum@linux.dev>
 <ZyoAGsCAdWrGMQoj@infradead.org>
 <20241105105339.8d53c034b0d3fdd66139cdec@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105105339.8d53c034b0d3fdd66139cdec@linux-foundation.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 05, 2024 at 10:53:39AM -0800, Andrew Morton wrote:
> > Might be worth adding that nothing does a sizeof of the type or
> > variables of the type, so just hcanging it is fine.
> > 
> > Otherwise looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > Andrew, can you pick this up through -mm as there is no freevxfs tree?
> 
> I assume Christian can scoop this up?

Fine with me :)
