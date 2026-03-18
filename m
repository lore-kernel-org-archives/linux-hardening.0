Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB273A1E67;
	Wed, 18 Mar 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841261; cv=none; b=cO2Hfqw0+BrITXUcuPW2BZkh0V6jEztlbP7TK+EzyJZOrL862lsdQT3c8JsJjesXcenacx9eEpAXbShE91g0E1GkBm4vbLq1VsnolcVh4x/aRuLCA/ONyz988+bBKrMQ1E/RiiXTrQyfA2RoKzlkolwgECH6OcHXJBrm9c3rThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841261; c=relaxed/simple;
	bh=P5G0CDacif4HsUnn1QJFo3uWCJ2vvAe0hY2GWGyq8/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCMiN5sFDU36t5NPNU9WTIdivQ2j4GiNM33+JUz1zABv8vBUtVyS4x3Qtv2VBn2asKMz2lRkZSiqOmyWg1UPNO+2akwMdlPi98tG8PvaANVnHHBA3Z6sTIpw3FUH4CLZSd3U1Mon+DGcsQ6YHkgcZ2b4w4jM/0qAOdavLR0qK60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZebq07U; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZebq07U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773841259; x=1805377259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P5G0CDacif4HsUnn1QJFo3uWCJ2vvAe0hY2GWGyq8/Y=;
  b=BZebq07Ub+VrAf/thv8ITmLGEUj9L0VxvO2SfvDdSgtxSwm+KevFeeNb
   zbyqlDa1xlyK4pnpRnYv4Do3ootsjko7e99Qq6rqKGlCDfA1oKUMOmJUG
   0k9MHTApgwNrnp2Pug1Hsiqsi2jTCQnu4cLaQHoxKNHDOykdT8uVdX0Va
   WtTn6gknORWR6zyvCylal/T4Nr9gq2N7dYhSs/qK5d91kv5qYB5CE/xJo
   ls3oeaeDYjYOHZbliMAF6RcfsmbLD79T3kRjEJt0gRKqQmIC6sxrREZ7j
   YvSfn2beGF6nNsqxisfFvQUhzeU5dX6IqfH3aWWdwbczmr1dSDYLOufxQ
   Q==;
X-CSE-ConnectionGUID: lYHY1/jKRWO/wlsErydXEA==
X-CSE-MsgGUID: BWXDmzcRQs6NFiGE5C+oeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85208050"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85208050"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 06:40:59 -0700
X-CSE-ConnectionGUID: xO0V8ntuTaW0GL8Wv+fY6A==
X-CSE-MsgGUID: zrK8iuQ7Sj6+IdqWWaq2oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="247111629"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 18 Mar 2026 06:40:57 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1BFFB98; Wed, 18 Mar 2026 14:40:56 +0100 (CET)
Date: Wed, 18 Mar 2026 14:40:56 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-usb@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] thunderbolt: use kzalloc_flex
Message-ID: <20260318134056.GJ2275908@black.igk.intel.com>
References: <20260316182112.8682-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316182112.8682-1-rosenp@gmail.com>

On Mon, Mar 16, 2026 at 11:21:12AM -0700, Rosen Penev wrote:
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index e96474f17067..4e66b53860dd 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -440,9 +440,10 @@ struct tb_path {
>  	bool drop_packages;
>  	bool activated;
>  	bool clear_fc;
> -	struct tb_path_hop *hops;
>  	int path_length;
>  	bool alloc_hopid;
> +
> +	struct tb_path_hop hops[] __counted_by(path_length);

Please update the kernel-doc too. Other than that this looks good.
