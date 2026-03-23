Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14577AD4B;
	Mon, 23 Mar 2026 05:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245245; cv=none; b=PwciPCKEBYEHNBcOEeIf7ZUaMvc0jIW50E32r5C82yhVhkfU/NWXz/ZGhS9sV5k2NtaqIce6YLlXNpSfljxTzTV09fNLEuJN2hXEV+huSzqWaeg0V1fKE75xwJvSNCXoqpx88Lx4l6nzIzDigSQG0vq0CnpkmhYyD/l26v8N29s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245245; c=relaxed/simple;
	bh=5Np89iEfAkaoUvFYor9oqdXgPCMO1WES0ZnH+qDTPxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMOD3eE67aBAkzp4CwolxyLvV7+gGI5YvgpQVIRuybkQWgtQF9V2EaBT2D4OzoiWY4Vc732IlUvbXQ7XgaegO3ye6cOwrEeNBDA7x6Qm2g2hIkB1+HV+PhW3RF62ZBY5zfYcyz5RTfmeTCtauOtxuLBD32Ewoy+M0EqKO3j1VXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aEY71oMW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEY71oMW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774245243; x=1805781243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Np89iEfAkaoUvFYor9oqdXgPCMO1WES0ZnH+qDTPxk=;
  b=aEY71oMW8P50ywDqzB9Vg1lKeIMjrRCzWB1k8EgC1Nx6q4hdB/esB5LY
   qnHkxr7a2aBCaPjEowXP4oJVqxqbwo3tYKkXos489NQF72qd62CFeXIfg
   7ul0PnCg8rbqzzRWwLtIqByMc4uq/Lv98LGkT5FgCKHCtxzOm2f+NHQ0n
   mcpteMM3UY/pODjRnuKojOs1cta7vOiovT9GqF4e1PuH+z9COjQJl25c1
   XcvyILtD02lzfpL7MvBeBAqRC3MaGs8tUHLauiWeWzvAHmfTwNanEfazw
   ZzFkxlsJyarhBfNT9PgXurGAW68oB+SGsPYYVsbX2wvpzAGvmVJZINg+/
   Q==;
X-CSE-ConnectionGUID: C/QoECbtSa2yQiLO/e3ImQ==
X-CSE-MsgGUID: sByAzvn1QFmsaGyNrtPbZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="85549584"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="85549584"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 22:54:02 -0700
X-CSE-ConnectionGUID: ALiZczb0S/W3xBNmG9F17A==
X-CSE-MsgGUID: aRewrqC9SISR1w+X2oTSGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="224140347"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 22 Mar 2026 22:54:00 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 28C6A95; Mon, 23 Mar 2026 06:53:59 +0100 (CET)
Date: Mon, 23 Mar 2026 06:53:59 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-usb@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv3] thunderbolt: use kzalloc_flex
Message-ID: <20260323055359.GV2275908@black.igk.intel.com>
References: <20260318185237.4742-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260318185237.4742-1-rosenp@gmail.com>

On Wed, Mar 18, 2026 at 11:52:37AM -0700, Rosen Penev wrote:
> Simplifies allocation by using a flexible arraay member.
> 
> Added __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to thunderbolt.git/next, thanks!
