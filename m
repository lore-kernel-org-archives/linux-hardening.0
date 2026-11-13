Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586159;
	b=xc+PxKuMK01nUzT0si2I/6BNy8O4iJYoVJHGXlN6Tn43PmyvUWS1+SDVv5IJLr5H/037
	 j9m7RrhEBB09CGsygmMtNKLyoMa0RFUI7KCrId/+5MLlrczNiHeK+cGCODSkIKPMBqGnR
	 /5P1w4JFTM1NrvK4dmQiZqaF7Ns2eASWSn79uvFgMwAdoTSGpARoEFEpBzHlLYS7ynCYb
	 CWDUlVaGWlo8nmsBBZSQxJ+KAvmmuX4JlnSu724lD2uY9L7Kc67keP67uXNbjlPYE+mVp
	 l2YxkAnUxJGfwCbhPjaE1Guy53B8xwrYG4+loVpT3ySXyXlUtz7NXKBcaflAJa7fS5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586159;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=UzRtJe9k/TIfMygxRi1Dshl9doPqG/GK6K3D7F5Qdd0=;
	b=hBl3idaaC+Qy2Co0UDWioPBBgcp7npy1wGbZjZeM7rmMVjqiiyuicB+YuhL2nL8uCwaJ
	 HoHw6FgKLe6IeCwP+4anG/6YG+j7izGKbf3mhtIHMsJPfxGAsBjjJ21p7sMtk1BEImNIB
	 bYmgT0dYCVmJionDBFAEgJGIVIb1DZED+JumnLBO5224myJQDu8a+8vyEhG5XP9AovRdX
	 3Ftgovkzk2wWSvWJ6POOFTqI9GiDo4oe6ueYQdxy89e1nVeiPTMV8EQNbpss/p+F+4x8J
	 iBgVp0KEO5nX2E5QvePgf05aQU68jG7OzyHJJsoqdX8mIj1PMjNOfViVkWL34nUed1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZtesTI3J;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB6607B698;
	Fri, 13 Nov 2026 16:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14BB6607B698
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZtesTI3J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794586159; x=1826122159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j7xpIOpqXoovT7Lty0XB42ypoT8ee6ey870rThtyt/o=;
  b=ZtesTI3J/w/a3DIEVxvIQOYyXo14saD9yrx08syALM2PRPO+fF+lpqiM
   7rKRqbaHnI8+2qgyFm0pLDCg/3HjFaDJnkf9pF3HhkanCu2KiXFSGLFN7
   TrsUZyopN0hN9aE3JwTxFDB4IMkCAOY0X8Bqcp2I8z2lL7bcjTs6HgH5x
   ToqiJP2keXLVTOwMlWI2Zd/KpgmKmAdT5Voq8qooiVpWNMPmzlTkZ4NoQ
   wXzD8FdI9BFVrOtqpbo953dMJXDpbCP11jcjWwLBOK8SReZkvNw6DL5Ne
   IB2Sj4gDEkLBpRV2eddKjaJWMQY11L0ekDS3FfuWfl6UoNiYGxJKEnEUn
   A==;
X-CSE-ConnectionGUID: HZtHW7ANQK+LHk567fr8BQ==
X-CSE-MsgGUID: jTkPJf15RTmfjsjMRsgWMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3384899"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3384899"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:09:18 -0800
X-CSE-ConnectionGUID: AGgDHqGAQmubd8uBvQL3xg==
X-CSE-MsgGUID: +fmZvJyNQ6ODkvVabY9eMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9385090"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:09:13 -0800
Date: Fri, 13 Nov 2026 18:09:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 01/10] lib: string_helpers: export and rename struct
 strarray
Message-ID: <avc2J6x6SGceeSNc@ashevche-desk.local>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
 <20261113-fwnode-for-each-prop-v2-1-4edc23d5cf50@oss.qualcomm.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-fwnode-for-each-prop-v2-1-4edc23d5cf50@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 04:47:01PM +0100, Bartosz Golaszewski wrote:
> Ahead of introducing a CLASS() for string arrays, make the existing
> struct strarray public in linux/string_helpers.h. Rename it to kstrarray
> to avoid any potential conflicts in the future and make it clear, it's a
> kernel type.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


