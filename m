Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F923CB;
	Wed,  7 May 2025 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601493; cv=none; b=W4y2HMX93hyHiIRlhpIIVqEUI8eXifQqDTmAX6Hvtia2cPIlviLy6n2MdAxU1p4NgZDQDR77R7LX4jqby7WSXyCM7IQn675isI+xqIei0QeRm4eVD2lUomlEw4sMk1W4tyxxkVZeKkL0vrgpuI6B4gkURnK2MFElJDCyVPD5SJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601493; c=relaxed/simple;
	bh=vAVFj6V13VH/4TS+igp6AT9Z2x39sJU9bJZyQAnqT9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL3rIMUQPQqZRg0+R15XpLUcVPPMIy1PJD9Xn+ioA+KTesGKveCPHTXIqE1cE4OlDDyqRpgfDigY4ebIgLOAVE2QGtlGUVsdqw6GxnBFhJkN7bU9RN1jMSORZjOAdzlZDhhZLV+PUM4t6wY2F9Xn4i0ec1nkiA5yKGgG0FYYwt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C8A1868C7B; Wed,  7 May 2025 08:59:14 +0200 (CEST)
Date: Wed, 7 May 2025 08:59:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <kees@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	kernel test robot <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Message-ID: <20250507065913.GA31959@lst.de>
References: <20250507033536.work.088-kees@kernel.org> <20250507044754.GC28402@lst.de> <202505062255.130383D3B7@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505062255.130383D3B7@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 06, 2025 at 10:55:31PM -0700, Kees Cook wrote:
> On Wed, May 07, 2025 at 06:47:54AM +0200, Christoph Hellwig wrote:
> > On Tue, May 06, 2025 at 08:35:40PM -0700, Kees Cook wrote:
> > > The only reason nvme_pci_npages_prp() could be used as a compile-time
> > > known result in BUILD_BUG_ON() is because the compiler was always choosing
> > > to inline the function. Under special circumstances (sanitizer coverage
> > > functions disabled for __init functions on ARCH=um), the compiler decided
> > > to stop inlining it:
> > 
> > Can we place just fix um to still force inlining inline functions instead
> > of needing these workarounds?
> 
> Oh, I don't have the history here. Is there something about UM and
> forcing off inlining?

Maybe I'm misunderstandng your report, but what causes the failure
to inline?

