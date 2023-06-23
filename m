Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247F5EB64D7
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Jun 2023 05:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjFWFAq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Jun 2023 01:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjFWFAk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Jun 2023 01:00:40 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD89226B7
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 22:00:09 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3ff27588ba5so3538621cf.3
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687496409; x=1690088409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/RGEzgP+aqX5ZY+j/ilBaNLtUkbB2eFzGxCWwZgKCI=;
        b=GLZRJdbgGtTqv7kuctUIXxgb6cawBVQJrpcuN5/GhnjlegY1NFLoLH7zHLxkjNFaZQ
         b94r93Hm6d+QZBJ4eK8rvvJpcT+5f2Dxs4Rxs7CuEreXRvcS6s9gI41FWfy+nLu/YXLD
         8BvhLEDbRu1sPIhCjlrKMq7D0xO4NFpgxMcrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687496409; x=1690088409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/RGEzgP+aqX5ZY+j/ilBaNLtUkbB2eFzGxCWwZgKCI=;
        b=exHEdjYgoXpKotldTGpsdCNmMMCs9UewnKOnAyFNlJsV5gDCE7Eju2C6cwBz02p0Hx
         aKINyaXbu4O5KN76rbY6mS8pjRdxJvSBvROsBnB/h7mkgzyv0bQkC0DYqws+WLz+X8oc
         JUA5kbt7I0hhge/Fitei8K/JO0GW7QgP+AowLSfoob1JZtmpFFM156kATeXFD7QRssdi
         x4KPKs/+jIhq+7K9e1CNq92ksoRYy5BlDOc33ErE1UUSVkwPy2oOMR5TFdPZ34YGKzNb
         E4vlOwdPDDwGDNbK1sbhr3at0GQceqqNNuF2gOqfUBe0N/Mlf8o0OJTN6anbS7/1j5gK
         ansQ==
X-Gm-Message-State: AC+VfDxnuxqOovBs5Q9TZGR4yO2KA2HuQB8S++YVqvmPwAjIh6IjacDs
        7KbUZYstnHu3c2uEAYgIIog8Cw==
X-Google-Smtp-Source: ACHHUZ5ZnGLETi8vnh4wvIFB6bEndLB6axcJukRFIugGjuXOszeZs9XSIiD//UEa+RbqdfXKgyAuyA==
X-Received: by 2002:a05:622a:507:b0:3f8:6924:a0b6 with SMTP id l7-20020a05622a050700b003f86924a0b6mr24623761qtx.50.1687496408922;
        Thu, 22 Jun 2023 22:00:08 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3383:b451:fa2:1538])
        by smtp.gmail.com with ESMTPSA id n4-20020a635904000000b00553b9e0510esm5487913pgb.60.2023.06.22.22.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 22:00:08 -0700 (PDT)
Date:   Fri, 23 Jun 2023 14:00:04 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ksmbd: Use struct_size() helper in
 ksmbd_negotiate_smb_dialect()
Message-ID: <20230623050004.GA11488@google.com>
References: <ZJNrsjDEfe0iwQ92@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJNrsjDEfe0iwQ92@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On (23/06/21 15:29), Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
