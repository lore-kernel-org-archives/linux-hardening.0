Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AEF373BE6;
	Mon,  7 Sep 2026 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779581; cv=none; b=PlYwiXkq0nowqxaJfFb7mNE6LaQNPIaCCZiFutUJqsYUIkRGIG1Zp4kwuV2OWJ+GigMxvB9pL+uQ2YJ8jrHp3FdZhiKZZlMtGpCJfL/v7El8CPGWV0ixmHh1/IB3iubGu5EnHfM+oR7N5sfP4BTNmRuC1iF4AvjNm8qzdaMCJrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779581; c=relaxed/simple;
	bh=3NpzqkRDSJ2Re9hFV4xZMFGqwbXJi62h++i1DkmAopk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJ/khOVZWSJTfy6UdqZrKmEX+SFmiTiNT6kgc49KlF/pIJUmIRNHrusl748R7a5u5ELoSgpC6PCP6nwtPYhdAQbj78KZjHzS9/a1Aho76AcT1PSoHnLmbs6vU/VAiPVZ+Q4VPR/tjsOUg3GsAlNesY/dYhg79ep3AUQDi7K+tYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c971gfQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c971gfQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201271F00A3A;
	Mon,  7 Sep 2026 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788779578;
	bh=js4xIImDF23m5mLsfLYUyO3X2kxaMaOaazWtNcIAmwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c971gfQTe8KP77JadAej1zuEu+Wr+Dg+hCHLT8BjIh5eWz0vlbZt9ShoxkHXleKTZ
	 ujbgx3oezNHVTFsTNbhmT4HPtWXuLgYSEg2DBNMx2oEUAnTQkW6Qg7sqLV4laBeRU0
	 F1ny4Clx5H3wDFhYSsSIW5EOkxvMIHYFEZ9VYYExA9keQLKwh8EV40l+EssPMCoaXH
	 D8UXzsHPa8lzsjyYzGrflXGrUh0iJXeH+TaVc7JucXNHoU6A1/utngb1LbXTLGMhPS
	 FaKHkk0ilLnm0u9mGUljhzowKPX2SAbcJ1uhkyTgUlvLvRDmaz90oug8n2odmSnurh
	 hohPAPied1sCQ==
Date: Mon, 7 Sep 2026 13:12:53 +0200
From: Thorsten Blum <blum@kernel.org>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lib/string_choices: Add
 str_supported_unsupported() helper
Message-ID: <ap6cNTShzhWZRKrU@kernel.org>
References: <20260907084319.351688-4-blum@kernel.org>
 <20260907084319.351688-5-blum@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907084319.351688-5-blum@kernel.org>

On Mon, Sep 07, 2026 at 10:43:20AM +0200, Thorsten Blum wrote:
> Add str_supported_unsupported() to return "supported" or "unsupported"
> depending on the boolean argument. Also add the inverse
> str_unsupported_supported().
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  include/linux/string_choices.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
