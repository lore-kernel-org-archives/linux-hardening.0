Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F030DEA6;
	Tue,  7 Apr 2026 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545331; cv=none; b=U3Lps3V6wigKLqVmzuctXTSXEJwvp0V4rXkaLQ2FAWQehjAdbXfMCaJE+74ggsY3zr3kYrw1uw7Df4akaAZYLQHV45tPlY+950tIi/6WtNJpcCNHfUW4nLKr4bYcgOBdFmwzh8tvseSAozxPLmketbqMkqN3mqyiRMyTPKlCxkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545331; c=relaxed/simple;
	bh=V3Pphi3z48sC6cwOlXjuB2roYc9KI1wSiuAh2leMyzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw26UFFlcNhXqA8UEj5r2RYUm1TYZUjE0uxMZFrdIIj1PNIluAi+OTLeIb7Jm1cTp2sbFQZUiejSjXqFsi79UrvJjkWDxjlYJTD3golgbuYHTAejSpWtRzUka0XSABgvNu3HFFA6+NeNwUhaYsSb25o3r/afYlP9i4g1+iFGEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXG7SbNI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXG7SbNI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775545330; x=1807081330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V3Pphi3z48sC6cwOlXjuB2roYc9KI1wSiuAh2leMyzk=;
  b=VXG7SbNIRfKM5tYict/aZzw8lH54oyjy+xJGoc6DH44eH46WWJ3MucoA
   5+oQdDcMhoVrsKs60S5XAN1Gqpj0cc5tRahWU6kxFPkSxTlEzvZ16qpBq
   SiChG7iPmOu9IkN9i3GgM6EHz4+ZawqernML/XzRLWj4wyTtgFv1c8Nlg
   7NHYdiXiZQqPtA+kiMe4Cp1h3GboeeKIllSgq7SC6eMrGsT0y1S6XIzjr
   xasP+BVIKiSfLjySz7hTOcAPqPiu7THxlRGoqAZFQN5diBNxsUo2C3G3G
   1yqgBX5NrtbOVbqg3fRHDm9ltb8NjJnSon+zVeiNwM58tbIiG8S4T+tWU
   Q==;
X-CSE-ConnectionGUID: LGBV01pBSROoi4WAA8TKJg==
X-CSE-MsgGUID: OD69kc9eQbqeRxTi5+jM/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="94080815"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="94080815"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 00:02:10 -0700
X-CSE-ConnectionGUID: 6HGZ4sFVRQiO9W7KR9tCcg==
X-CSE-MsgGUID: mxdhmdZYQLKhdFIaTuKD5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="251375736"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 07 Apr 2026 00:02:08 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id CFB9195; Tue, 07 Apr 2026 09:02:06 +0200 (CEST)
Date: Tue, 7 Apr 2026 09:02:06 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-usb@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] thunderbolt: tunnel: simplify allocation
Message-ID: <20260407070206.GE3552@black.igk.intel.com>
References: <20260401214726.3911-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401214726.3911-1-rosenp@gmail.com>

On Wed, Apr 01, 2026 at 02:47:26PM -0700, Rosen Penev wrote:
> Use a flexible array member and kzalloc_flex to combine allocations.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment after allocation. kzalloc_flex with GCC >= 15 does this
> automatically.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to thunderbolt.git/next, thanks!
