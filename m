Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D56436897F;
	Wed,  1 Apr 2026 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041742; cv=none; b=L+0bWwROrPAokveLkczBIGeATkjh2NifF7iBvw6swsOW0nfX1GL8gVBbuODrAkbUM53l77OnqgjD6xNr6FOL4zjDrZ38wNpwNu1CK/jbkUeqUs/rlQSPmMiaZeZDdDd/51iyTva6hvyhAr7AVFFzl+AcOD98I5eRXRwYVk/DbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041742; c=relaxed/simple;
	bh=Zxi+Ax8a1EFVtCv3R8GcG1vgZHfp9YtzaQh1YjP/3KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIDxiSGauH1H+iG3nKSn0cC71/1OsA5r/NXXLswhDtjUqg/TVK/OliyQ+ybfDflnbXCu4O1iestXdSpUNJSdaGOTey/2DgrbAIkyZlnbEdpFJX6TUG+noXWsgkrVceyu+3SGKiQDMM3hv6QhTzliAvJkaB0Wn+CgCzFJ5DCt6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXSG/YiH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXSG/YiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775041741; x=1806577741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zxi+Ax8a1EFVtCv3R8GcG1vgZHfp9YtzaQh1YjP/3KE=;
  b=NXSG/YiHYAB2xkPMgYYdZJ71CcJ8V8GBRWB+UE0XkXcgQlaHJrWgjO6g
   HmFoMBliMiEcy7uVwJl57MXZNpcSMaLufrBwLaU4PqTBv0H11AmyD6y8w
   jCCIGbYoh3sHp8+59crqWomdHtfynypCQpLQExG4uLq6BKEL2LBOZABTx
   N8rrxlANdPpfFcA/GEX9CzxR4/sgQFm3aP5n5ULicrYHPYg1h4500Nn7Z
   OmwAvke1L10HJwO1Iv4XMbpucwSmoqz34uqFz8zQALl0IDjnYcvPRI7fi
   w4QOFealovdg4xDP2XT6xNJvVhd4f/lSQCoNS/sQhsA/GMIpGrqKIxH52
   g==;
X-CSE-ConnectionGUID: BI9UrpwURxO4+G7LUZe55Q==
X-CSE-MsgGUID: m0OHGU69TLyjL/1yhjUEtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79930870"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79930870"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 04:09:00 -0700
X-CSE-ConnectionGUID: m6P+EwcBT0CN1EKk/rbGmw==
X-CSE-MsgGUID: QldhNkYSQumcxyP2VWiw4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="228260147"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 01 Apr 2026 04:08:57 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id D244A98; Wed, 01 Apr 2026 13:08:56 +0200 (CEST)
Date: Wed, 1 Apr 2026 13:08:56 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-usb@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: tunnel: simplify allocation
Message-ID: <20260401110856.GS3552@black.igk.intel.com>
References: <20260330211014.12121-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330211014.12121-1-rosenp@gmail.com>

On Mon, Mar 30, 2026 at 02:10:14PM -0700, Rosen Penev wrote:
> +++ b/drivers/thunderbolt/tunnel.h
> @@ -75,7 +75,6 @@ struct tb_tunnel {
>  	struct tb *tb;
>  	struct tb_port *src_port;
>  	struct tb_port *dst_port;
> -	struct tb_path **paths;
>  	size_t npaths;
>  	int (*pre_activate)(struct tb_tunnel *tunnel);
>  	int (*activate)(struct tb_tunnel *tunnel, bool activate);
> @@ -107,6 +106,8 @@ struct tb_tunnel {
>  	struct delayed_work dprx_work;
>  	void (*callback)(struct tb_tunnel *tunnel, void *data);
>  	void *callback_data;
> +
> +	struct tb_path *paths[] __counted_by(npaths);

Please move the kernel-doc to the right place as well.
