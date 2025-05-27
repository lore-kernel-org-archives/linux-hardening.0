Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E131AA782
	for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329359; cv=none; b=UY+NBchQgvdkc9UPzKfZDdLrjrs5A8nypHp1AswUyyAdDdKkZj9aOcvGNQ73DHc28Q2xwEXDrfFG9uLwXHB86wog5Ql+KDNfmioIX9cJQ6gdM9hwhBZzAuNHGo/g5m5OBHpCj/ITDFBfOePjty0wG2Rn+h52uoJgH+i3Qcey82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329359; c=relaxed/simple;
	bh=uerM567QcQCVqLcNbyZwn68Uozgpe9FXmx2lyhpHDvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3Um1/Sj8eWAxnGOmXWVXW81ER0Xc6nIRJACbhfba7TCj8rfPdJ142wLfhNe7Pe6dCvl8Sgto9+pKISFRC1JNl1fgz2Aey68AVV+5iFIN/sOmDB+CT9c0QqRkJ/61ko8CQYoFwHn5byT+PrmnyyZDzxxaTzbPVhne6DBnsGGZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqPpYETw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqPpYETw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748329356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPj65lDKBn8X+w6dITxUNDiVhmFCDqyup7L8wrKjKWs=;
	b=JqPpYETwDR9apyi4F98zawnyfJY15s11vKJifcLqjXQED0w3msmaVvrHe80yO0yfX0dI3v
	ofRVKNRVpLJ6hF32w4Lps8Q+ovtgMbDpgJcDVFAIEpgHEM4Q4bQCIiEbcaRX0ksY6zP6mm
	zGoMtxTsxb2mCKRF6pyCYEhO+LU1Iq0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-xAEyX0ZqOOqzlxIYueh35g-1; Tue, 27 May 2025 03:02:35 -0400
X-MC-Unique: xAEyX0ZqOOqzlxIYueh35g-1
X-Mimecast-MFC-AGG-ID: xAEyX0ZqOOqzlxIYueh35g_1748329354
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4d51e563eso789102f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 May 2025 00:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329354; x=1748934154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPj65lDKBn8X+w6dITxUNDiVhmFCDqyup7L8wrKjKWs=;
        b=lUW7eZdtxzjIhbXWe/Dxayw7Y9kzME0ZZ2jAJ7mg6OaTOcnikcCoG9qEkyNDI7i+Pa
         O9tDXmtZx493cYisZ9G7qZH+ZfZX3dWQt9xwUd/0vWgfi9NTDEfdHfLvUyqWF0S11Ohi
         RKWSqmEWvlCB68zqr/ZojeXD8McVGZQmy+Ozo/6h1tXBjTBy+njQWtmvDWnT4wVtWE6T
         6B5hZGp5hHYKjBjrUVlsu+CRsuWLCGLo0+5modzqK7WdDUtNGajLOqHQMNnFx3kopljc
         dm3Mphmfm7coRAT9DubdhlDOkmWwfhUXCoFbbU4p+n5W6Cqg7FWQLP+HIsEp5PRrlzyP
         Mh0A==
X-Forwarded-Encrypted: i=1; AJvYcCUsAfgp/HDKXd4VoUWMC3ln2KMhbsrHpcn4HX03hTfEED8piUfjJTz5G7B8qIYIRo+Zt2grs2D9skzVfEDPhPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiuh0jHqDX2SnX+1DNJ/eQtMNO3RR8uK6+Xy12xetoxrRozHhn
	bJLxPAwnkVdbr1S/Pau5keWG/y0ntg/IE7z2CW+W+byu5d/etR4hV8FV2AvIfMrS+YmRjf9JY4I
	lMCv6F912KrIYvTBRjDP1/gjPwJJyZjC1je0IOGAbuBxcXGb6dBtJ4cF+np+QE17w9gRTZA==
X-Gm-Gg: ASbGncsGp9Cobh/UlpbDlQH3ekJf0v2XeYO0O6bAXsdpD1SPJBL9U+v/T3+dq0IVjEe
	BuuVwqIkFhvypIPWdg/1ZT3GMeMqFJe8exSr+nPSsVHzhb0Co9r1lKzMcW1on6o6jqY6jSVqe8h
	XR53lEin+IbqkCpqXwy1zhZFnUgu+m08WWwDOIrgoQtZtV+dpkIhoEmYwzUehcOt9bICIhG2kQZ
	d5Zq+NckRALCDsnyI7Ny9ZOwveGVWR+pgg4cXySUVQaxQ6KUrpOClZU3NnNRP7B0c/Bj8tay0k6
	LUE26zEMlpjnPRa21qurjFMvJUa9sFH0k/lJs1ktJ1i3IlwXsSjYAp1FzGI=
X-Received: by 2002:a5d:5543:0:b0:3a4:cf66:efbb with SMTP id ffacd0b85a97d-3a4cf66f1f6mr7608603f8f.57.1748329353530;
        Tue, 27 May 2025 00:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGex5mHhM/OYaq2gRKUAD/HxHUJY3MptMrHBU8jm/eQhY8uxpjEvS25/QUCzUXZRuezIVGAwQ==
X-Received: by 2002:a5d:5543:0:b0:3a4:cf66:efbb with SMTP id ffacd0b85a97d-3a4cf66f1f6mr7608571f8f.57.1748329353087;
        Tue, 27 May 2025 00:02:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4cc52ab88sm9930473f8f.11.2025.05.27.00.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 00:02:32 -0700 (PDT)
Message-ID: <e1429351-3c9b-40e0-b50d-de6527d0a05b@redhat.com>
Date: Tue, 27 May 2025 09:02:28 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/8] net: core: Convert
 dev_set_mac_address_user() to use struct sockaddr_storage
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Cosmin Ratiu <cratiu@nvidia.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Maxim Georgiev
 <glipus@gmail.com>, netdev@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Mike Christie <michael.christie@oracle.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Maurizio Lombardi
 <mlombard@redhat.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Mingzhe Zou <mingzhe.zou@easystack.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Lei Yang
 <leiyang@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Paul Fertser <fercerpav@gmail.com>, Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Hayes Wang
 <hayeswang@realtek.com>, Douglas Anderson <dianders@chromium.org>,
 Grant Grundler <grundler@chromium.org>, Jay Vosburgh <jv@jvosburgh.net>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Jiri Pirko <jiri@resnulli.us>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Philipp Hahn <phahn-oss@avm.de>,
 Eric Biggers <ebiggers@google.com>, Ard Biesheuvel <ardb@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-wpan@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250521204310.it.500-kees@kernel.org>
 <20250521204619.2301870-8-kees@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250521204619.2301870-8-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3FbiuE5GJjhNb-gz5vGplifeuMDw6gNzMWbBrF7B_pw_1748329354
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 10:46 PM, Kees Cook wrote:
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index fff13a8b48f1..616479e71466 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -572,9 +572,11 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
>  		return dev_set_mtu(dev, ifr->ifr_mtu);
>  
>  	case SIOCSIFHWADDR:
> -		if (dev->addr_len > sizeof(struct sockaddr))
> +		if (dev->addr_len > sizeof(ifr->ifr_hwaddr))
>  			return -EINVAL;
> -		return dev_set_mac_address_user(dev, &ifr->ifr_hwaddr, NULL);
> +		return dev_set_mac_address_user(dev,
> +						(struct sockaddr_storage *)&ifr->ifr_hwaddr,
> +						NULL);

Side note for a possible follow-up: the above pattern is repeated a
couple of times: IMHO consolidating it into an helper would be nice.
Also such helper could/should explicitly convert ifr->ifr_hwaddr to
sockaddr_storage and avoid the cast.

/P

