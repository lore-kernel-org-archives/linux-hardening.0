Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A5D203704
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255801; cv=none; b=qA1/d05d5pG6byEbWOIBhq+4XZnxv7RXp1tzGUf1ziH9t3TzpnvFOjj9sThtrD7YPl18Swb0qL4KOdu/wmIBkwjeQ7MpyQeoZaOHKwuLDV/GVZHIhlz4V/iwo2ASDlYiUWaHPRBJXPxqf8AtkkSlywrI7erNKTPkNoUNWZhMF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255801; c=relaxed/simple;
	bh=Ysjf2OBPK+7lL0p0Kkrh9+GmuYhpmnc7ExeCH0spffo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eru8AmWy7Pvt2tavyI4FU62lx4dmVUqgDawu8Gt4qbl5iDIX54ovmGcaNCW7Mhe6zfCulH3wHTyh2+HrMUDApliCCfntGAZSvoc4IMYqEWX4XkQrBVDwZwl8rnBe07eKmqCpicjtN7zJrCcxrPtmrfTP6R0zGcbQXDGSR6h15ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ji8f1Xi3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ji8f1Xi3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ysjf2OBPK+7lL0p0Kkrh9+GmuYhpmnc7ExeCH0spffo=; b=ji8f1Xi3aYkLJFJGb8+khtGU/W
	n1mXpETW+aegAdcTfhspyKITv4jJtQZF2i/Rj28KUk9B4et7yzK2r8kuwxNHtYSEHrrZZfM7co2eA
	SZmM8lpyr5AAp1oHIpOzXRx+MM3yPckQU6Jgdb3HtkilRj+vN4x1Q9gGj+waIyXmCD9ddxWHffXV5
	TLQAjVEtnFGL47EzoQqJ9bIEf5vA3RQs4qqwfAWygH1uSP/tCLJ6p5P7smRI2pTx+aX60Fdd0XdtF
	MIWB3JkQrpe4de4V83SYzGBHqh2dMilQjh4jpwTZbVAtCEOh0QT330YD+uiWqVnJ6W0+MMazb0OK8
	+oNL7mJA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tIZ0d-0000000AAHe-0Qcw;
	Tue, 03 Dec 2024 19:56:35 +0000
Date: Tue, 3 Dec 2024 19:56:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, zuoze <zuoze1@huawei.com>,
	gustavoars@kernel.org, akpm@linux-foundation.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	keescook@chromium.org
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass
 the vmalloc check.
Message-ID: <Z09icnP7QuaLg4Qv@casper.infradead.org>
References: <57f9eca2-effc-3a9f-932b-fd37ae6d0f87@huawei.com>
 <Z077_8rNvTGrCb8L@pc636>
 <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
 <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com>
 <Z08KAupLBo--JGz8@pc636>
 <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com>
 <Z08M88NdLfugqhu9@pc636>
 <d659d925-a322-4566-955a-97894a2aa795@huawei.com>
 <Z08TlFqWVWs47g9z@pc636>
 <Z09VwuhfQbbro-gA@pc638.lan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z09VwuhfQbbro-gA@pc638.lan>

On Tue, Dec 03, 2024 at 08:02:26PM +0100, Uladzislau Rezki wrote:

I think there are a few other things we can try here.

First, if the copy is small (and I still don't have an answer to that
...), we can skip the vmalloc lookup if the copy doesn't cross a page
boundary.

Second, we could try storing this in a maple tree rather than an rbtree.
That gives us RCU protected lookups rather than under a spinlock.

It might even be worth going to a rwlock first, in case the problem is
that there's severe lock contention.

But I've asked for data on spinlock contention and not received an
answer on that either, so I don't know what to suggest.

Anyway, NACK to the original patch; that's just a horrible idea.
