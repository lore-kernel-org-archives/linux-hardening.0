Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71D8C433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 02:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJRCtj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 Oct 2022 22:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJRCti (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 Oct 2022 22:49:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBB31A216
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 19:49:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y1so12847153pfr.3
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 19:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTODrlB+7AJnag9/P4yyzzC7WqRXAUlUkTowiwHkiWM=;
        b=DydS8spoH83GUDzf8tD3YG9MwEPxUB4hyDkgm9z90W16uxzbFNH7mi9OXPLglNkEnr
         mcw3zoEoHoenTDW3VGWj7lo60QmOE7Nu4u6AuASkSTfRYORo9Ch36dMQrlPWPgfBTN/a
         h0QDjb3JMkfYK2VQT7KPhvGy3tLdka75tFTPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTODrlB+7AJnag9/P4yyzzC7WqRXAUlUkTowiwHkiWM=;
        b=GJ7mBK3l7jHZkO7sG/Y/Zhf0G4TDUt/QHz8yiuD6MqB/YRKGypwpsxq+QDQS58iIHZ
         O0bPy4t94b+d9BJxfc7ZO8HXaC4NPgGECOKlkHi9iY5Sz1kGVtfyq8ghhYv1d0K8UC1P
         klqdBIrxys6osVLjydum0zF4oVDeS4P5fgiFvelbJQKeGNMp2td4A0KLm40dsZ8EMJQi
         +xnB3dhXhhO89K744zuWsWDQr4F2BIR1ltT9KwWc6Wem9x1NDan24ByP++mng5PBRIi+
         H40lFK0KxIquaHr2Fy3py5EQQ30ESV4Lp5mL1C11VNmTAcHxOC0AuHUBCsFqLXyyMeG0
         F94A==
X-Gm-Message-State: ACrzQf3VmRUJP2Si6gZdoL4V64QXZARKrDf1+66TdqrjgiZTOWtzXQ21
        IpmUyfZ7nTHwofUPeYKeDKeaGQ==
X-Google-Smtp-Source: AMsMyM515OHxY++GdMoPEtD7YGrxz70dJ16U7PpqVIiXY2ncUxZpd3i42E2cFMdd4LDmEuWTIlbAjg==
X-Received: by 2002:a63:6c84:0:b0:43c:700f:6218 with SMTP id h126-20020a636c84000000b0043c700f6218mr788153pgc.420.1666061376633;
        Mon, 17 Oct 2022 19:49:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 64-20020a621943000000b005601e974993sm7814654pfz.25.2022.10.17.19.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:49:36 -0700 (PDT)
Date:   Mon, 17 Oct 2022 19:49:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/6][next] zd1201: Avoid clashing function prototypes
Message-ID: <202210171948.E275139C0D@keescook>
References: <cover.1666038048.git.gustavoars@kernel.org>
 <b16526a7a35638224990d265db21c8b450b67545.1666038048.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16526a7a35638224990d265db21c8b450b67545.1666038048.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 17, 2022 at 03:35:57PM -0500, Gustavo A. R. Silva wrote:
> [...]
> @@ -1678,12 +1682,11 @@ static int zd1201_get_maxassoc(struct net_device *dev,
>  }
>  
>  static const iw_handler zd1201_private_handler[] = {
> -	(iw_handler) zd1201_set_hostauth,	/* ZD1201SIWHOSTAUTH */
> -	(iw_handler) zd1201_get_hostauth,	/* ZD1201GIWHOSTAUTH */
> -	(iw_handler) zd1201_auth_sta,		/* ZD1201SIWAUTHSTA */
> -	(iw_handler) NULL,			/* nothing to get */
> -	(iw_handler) zd1201_set_maxassoc,	/* ZD1201SIMAXASSOC */
> -	(iw_handler) zd1201_get_maxassoc,	/* ZD1201GIMAXASSOC */
> +	IW_HANDLER(ZD1201SIWHOSTAUTH, zd1201_set_hostauth),
> +	IW_HANDLER(ZD1201GIWHOSTAUTH, zd1201_get_hostauth),
> +	IW_HANDLER(ZD1201SIWAUTHSTA, zd1201_auth_sta),
> +	IW_HANDLER(ZD1201SIWMAXASSOC, zd1201_set_maxassoc),
> +	IW_HANDLER(ZD1201GIWMAXASSOC, zd1201_get_maxassoc),
>  };

Like with the others, leave these as-is...

-- 
Kees Cook
