Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73A156DF
	for <linux-hardening@vger.kernel.org>; Fri, 12 Jan 2024 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hoQ+h3x+"
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id OKj5raspUAxAkOMVfrYzfv; Fri, 12 Jan 2024 18:44:03 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id OMVPr2w1oKleDOMVPrczHQ; Fri, 12 Jan 2024 18:43:48 +0000
X-Authority-Analysis: v=2.4 cv=KcbBDCUD c=1 sm=1 tr=0 ts=65a18864
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=7YfXLusrAAAA:8 a=beM7OXizrj4IlsfoTHwA:9 a=QEXdDO2ut3YA:10
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WN5oEk254ZaRQR4Ymvk869NpqFDbzV2Pr93bBRSvIRo=; b=hoQ+h3x+imlNEWxUJKBGFHyIu4
	uJuUL24a3DF6wvOgZf6CzqaDEXWkXBSPYMemz2IHFmFQA6c9NNFihtQVuzWgu9WgGUAtsUH5rLoYM
	ujADmEEAizAuHZsE9vTELnINHQsXv2+TcU1sxVEyZltY/MYedr9pysc0TQDqHhYITYXWmIFO1oCE7
	ps/6AZN0fNKItjtG3hp6bF0ylfL91caP3jxOAYGHIfu681EMAFwSmvBVb4tWfsyfxa27KkaGrKtQi
	ApAOeFwlKNEFNjxBA2LYPN1K9Q5Cd7C9laPOHt464ah8Za8QE8z9PxOFe0+6Yign0gmFq0rRtIL9Z
	DE77ToCQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:58358 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rOMVO-003hk2-2R;
	Fri, 12 Jan 2024 12:43:46 -0600
Message-ID: <1a48103c-cd7a-4425-8c17-89530f394a7f@embeddedor.com>
Date: Fri, 12 Jan 2024 12:43:23 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: csiostor: Use kcalloc() instead of kzalloc()
To: Erick Archer <erick.archer@gmx.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Justin Stitt <justinstitt@google.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240112182603.11048-1-erick.archer@gmx.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240112182603.11048-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rOMVO-003hk2-2R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:58358
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOJojukDkMYHkgu5qjNhm45TdEFRd17lkQ95n612/Rx2rAUbekhihXTaWZsPUMzMHm0XJcVKMWAIKs75CjSiB6LJnjR3TB7v4JsLgG42RE8CKiXSytHi
 99ZudH6uOaMiVY3dKIV6chn5tr7KzoeovegNCV32LVWCNDV18AGpL8TajPlaeU+F5XfqvvTbDIS1cwR94aDLEmVpLw+6yFgty3QLm56i3nlGrJ8OaZCvT6WD



On 1/12/24 12:26, Erick Archer wrote:
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>   drivers/scsi/csiostor/csio_init.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
> index d649b7a2a879..d72892e44fd1 100644
> --- a/drivers/scsi/csiostor/csio_init.c
> +++ b/drivers/scsi/csiostor/csio_init.c
> @@ -698,8 +698,7 @@ csio_lnodes_block_request(struct csio_hw *hw)
>   	struct csio_lnode **lnode_list;
>   	int cur_cnt = 0, ii;
> 
> -	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
> -			GFP_KERNEL);
> +	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);

You should also mention and describe these `sizeof` changes in the changelog text.

Thanks
--
Gustavo
