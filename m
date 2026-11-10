Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304923;
	b=LhuyWSbwVMguoj9Yt4cHpdvIcZbVtQG1GCBBzG8vTW4tF8+9CPpcaaVWcBjZ1TX6wTPG
	 D4tua56sIq7vUzSxe/NfxOu0ejceCn1mk6FYRkG/RsdkW/pGP2MjvxN6y4v1ZPQv+ISiV
	 /It/mrz1RnykuIdzFuOBC7cMSH9JQC7LKc0pi2DZ3ijauMN+dbolsBh2FdVYu1Vg0z/ZR
	 ighknCI5d70qFhStnojhZQ4Jr+8iw1HWjy3ezRD1QRrs+1gQkmiCO6KkNcH/rr0G1dugh
	 sJDw7aaA1ZxtjwNC3dBKt5myneFxKOhXes+lx4bko60UfpT9uFAF9dKiCzf4zIxqlSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304923;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=4zgWB+d5H5yTa9tvRw1sPy7h8ZaIadZT5pec+9DNROk=;
	b=4f8iNbNRxWIIzOpO1wjAAPr3Q0l+Tv2tAOtu+3TDyoBTWSnGhsog1Bm9+sluYPqi0pqH
	 w5K5m+H48zR+oCzaiX+ZXsDDltUiO+PkvPU7TKh6YSIZqrkwz1p7dJORg+oeBbNiCIl/A
	 erv/u1lvJ/PkJ6ktMeTcb3w7OIlKKQV3xyFjshd138yuZZGtELbULu8VFouDwJEGJtlNM
	 xCrsPew5DN5EpLAjUwEf06nbiBqJBKHt92kRzVI9F644o2owqOI590VXAEp6qspRA9ice
	 SkzQqlv64aP3NxZWneDykJrno0r1H6OKp+GY+t1JTan5qqKmb01I96CU1aIqCvQ1DJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MgjllcZm;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85DE606A334;
	Tue, 10 Nov 2026 10:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D85DE606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MgjllcZm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794304923; x=1825840923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J5Wc56c9jMQ0107g8hx4PjcxQ3z1p91ZWMX5oWjHcfw=;
  b=MgjllcZm7zQ+MlKC3x/IvnNekUzGYXZ/Q6wUTS5Gw1jkALDZh/gXQ2VO
   bEBH5XnS7BrxhnJfCgfN61oCScIE+2uZ7xQKuaxvS+Zy0bKYAKf8J86Lu
   espcRFPzjXiHFl9m4zsng3KIE1InwQQnQtlOx4te4h+n3FRUw4tpkgD6q
   gK7iGSxSpbYnudWLvWgzXt6aBb2BiafzlPTPRdFCZ2qqOGpC1uXUk6kZp
   wdlVPApfqOg+7JAQ4i20U41CbPQUHu2CKycJ0g6UH2xeAIFjEUxV99ByV
   M1j9EkgJjMx0wxma08tHmEmBZV1N6QT4pLf9BfnLTOHtMkpKDmlwa1qoB
   A==;
X-CSE-ConnectionGUID: IqKKWk89TjaVg6Ktao0IkQ==
X-CSE-MsgGUID: uTzCOi/JSfSTVgnMbAe8Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3071767"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3071767"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:02:02 -0800
X-CSE-ConnectionGUID: 7/z6BoevQjuFtNSEt4VzUA==
X-CSE-MsgGUID: MDkkPIf+TDODMn/JYVlmIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7943054"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:01:55 -0800
Date: Tue, 10 Nov 2026 12:01:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: longzhao@ambarella.com
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, devicetree@vger.kernel.org,
	Long Zhao <zl020895@163.com>, linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v14 13/14] lib/string_choices: add str_rising_falling()
Message-ID: <avLrkPb8z35ou_vw@ashevche-desk.local>
References: <20261110-cv75-gpio-v14-0-e586aad0467a@ambarella.com>
 <20261110-cv75-gpio-v14-13-e586aad0467a@ambarella.com>
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
In-Reply-To: <20261110-cv75-gpio-v14-13-e586aad0467a@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 12:32:38PM +0800, Long Zhao via B4 Relay wrote:

> Add str_rising_falling() and str_falling_rising() for code that
> prints an IRQ trigger edge.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
There are definitely more candidates for this, for instance

drivers/mfd/tps65010.c:280
sound/soc/bcm/bcm2835-i2s.c:612

-- 
With Best Regards,
Andy Shevchenko


