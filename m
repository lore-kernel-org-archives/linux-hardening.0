Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78938267AF2
	for <linux-hardening@vger.kernel.org>; Sat, 20 Dec 2025 04:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766204419; cv=none; b=uc/TLV+u67ddHYB5cnhpTNKC6WIn+Ti+MlgBKA++KNYJj1jaDRND/pxwr3C8v3X6ci3W5cxV171f8mUQ4jqdWpjDltmXugGr6lwBPUf7m0VnSwET4A7OH5e3nKVYuZSMAhFHai0JA3pEJ9t+Ut1VJ6qrpfvTnqvNJPpAM65umng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766204419; c=relaxed/simple;
	bh=icrpJhOrHzN1w/BxS6MLquQdQ/XVQQ8eBSbQkS8B3d0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=YbOYHD67aAhjDABiIQj23xkBtmTkCimtQJdjdXvD6Va++daVFAntVBXDyfExyFtRTB22gRwpQXYwNqujh4tK1Bho2I415zMF1yzOSEC5RRwjIgFVb/6NTQEC6ezSt8+4AngmFlHDUpiXSuUfaAXA1i8WySxDayNn8u9PlFYxjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=atoIBtVN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="atoIBtVN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fKaEL6Ojgmgiqu/WwkiRMd6jGBm5hHntfnKxlBYkrCU=; b=atoIBtVNujKhQiOrhoJ5szAG/T
	TCYdGsIokV+flOtJqhzm5eH696frcvaxT4WQ0Mq2LREhS0tlSziL0HHrOl0BStk3iUOPW/1fYZq8E
	nnb3TWCLjL+tvcuqBNy8SbVGtAfeMEHl8RyIwp8gZCzLQZ/+naC1WDIelhELYzfircr58k9ZQWofn
	WdgL1x1SaAl5eikyugiAqoBcVrlj3eRRVFnl46BF+zyeY67dubfB8bDKWuKA8GeJCoGYHZgMO+aUX
	IbJcxGbad+pSuE7se/Puvw2bubyeawyCL9rqWtMs20R/wCDU30lh8dMcnDdKAZL7onst5TJScnvjM
	nSD7gWDQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWoRy-0000000BI34-3G7H;
	Sat, 20 Dec 2025 04:20:14 +0000
Message-ID: <90e419ad-4036-4669-a4cc-8ce5d29e464b@infradead.org>
Date: Fri, 19 Dec 2025 20:20:13 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kees Cook <kees@kernel.org>, kasan-dev@googlegroups.com,
 linux-hardening@vger.kernel.org
From: Randy Dunlap <rdunlap@infradead.org>
Subject: UBSAN: array-index-out-of-bounds
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


from kernel bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=220823


Dec 15 22:01:52 orpheus kernel: UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.18.1/work/linux-6.18/drivers/mtd/devices/mtd_intel_dg.c:750:15


(from drivers/mtd/devices/mtd_intel_dg.c:)

	nvm = kzalloc(struct_size(nvm, regions, nregions), GFP_KERNEL);
...

	for (n = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
		if (!invm->regions[i].name)
			continue;

		char *name = kasprintf(GFP_KERNEL, "%s.%s",
				       dev_name(&aux_dev->dev), invm->regions[i].name);
		if (!name)
			continue;
750:		nvm->regions[n].name = name;
		nvm->regions[n].id = i;
		n++;
	}
	nvm->nregions = n;


regions is a flexible array in struct intel_dg_nvm *nvm; [see below]
regions is counted_by nvm->nregions.

Question: does UBSAN use the value of the counted_by variable for array bounds
checking?
If so, that means nvm->nregions must be updated before the array entry
is used. Is that correct?

If not, how does UBSAN do array-bounds checking in cases like this?


struct intel_dg_nvm {
	struct kref refcnt;
	struct mtd_info mtd;
	struct mutex lock; /* region access lock */
	void __iomem *base;
	void __iomem *base2;
	bool non_posted_erase;

	size_t size;
	unsigned int nregions;
	struct {
		const char *name;
		u8 id;
		u64 offset;
		u64 size;
		unsigned int is_readable:1;
		unsigned int is_writable:1;
	} regions[] __counted_by(nregions);
};

thanks.
-- 
~Randy

