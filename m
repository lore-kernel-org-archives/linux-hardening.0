Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2C014A84;
	Fri, 13 Oct 2023 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GvuyTF2s"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5B3C2;
	Fri, 13 Oct 2023 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LEtAjodcJ/masj4kckhIy1BBA7kQ7KM+p/SAstlOZeY=; b=GvuyTF2s1HPxK3pUf3vFwyREcJ
	6CKRRLiOx5WLrj5GspnoE2MgyzYNBpEAlC11DxfSp3Ge+UNcFw1eBL6xD7AA8rHaSyMNtbC8MYrC8
	iEoMZ9N8OuocNeeCa4h+pTaks3uJ6xBOfH73KYadD5Nzk+xk1Hco7N2pUWXqykUu0jMQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrHBs-0025VY-7b; Fri, 13 Oct 2023 14:22:52 +0200
Date: Fri, 13 Oct 2023 14:22:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Stitt <justinstitt@google.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch>
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -	for (i = 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++) {
> -		strncpy(data + i * ETH_GSTRING_LEN,
> -			tja11xx_hw_stats[i].string, ETH_GSTRING_LEN);
> -	}
> +	for (i = 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++)
> +		ethtool_sprintf(&data, "%s", tja11xx_hw_stats[i].string);
>  }

I assume you are using "%s" because tja11xx_hw_stats[i].string cannot
be trusted as a format string? Is this indicating we need an
ethtool_puts() ?

	Andrew
