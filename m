Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA1EC77B7F
	for <linux-hardening@archiver.kernel.org>; Thu, 11 May 2023 16:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbjEKQ0c (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 May 2023 12:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238831AbjEKQ0a (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 May 2023 12:26:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF4C5FDC
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 09:26:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ab1ce53ca6so63991545ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683822387; x=1686414387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndBrQ3w0AHpWG5hJlqPBYuez6El2zpi53yJoXY7Mu50=;
        b=e0/UwYTlRtR2RbPrnGw3TEV3B0HEDL/iXR+Q2PlPbNY5XTUy7Gn1joONOUh7sEeZJQ
         iC843L9UHEbDTk0Ge7TeWWHWKypOeA9fJ9g7nDuiZ+v7peGZ1bOQ+FH6HBFsip8lCJ3G
         hocIjwqI14UzBOfRXLrP3aNFoQIRy1PFjeKHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822387; x=1686414387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndBrQ3w0AHpWG5hJlqPBYuez6El2zpi53yJoXY7Mu50=;
        b=O1G//gQbBk5Y00jYHWCl7JvrTD8/HED1u/TRVa8NvS+MFC/xNFLbHX+ytfxzEKrjCQ
         /Q0TmyqAPJgcZ1BkvvNbvUE9NlVdaxvzZk6dB3XNjexJbqrcMdIxv82axB0JAJIc9R5i
         ENg35evEmHEXxmdb/qANtHVSF5hQiH94gV86kdeRkGBypMVZUTscDcVziE3Y6Ll71w/e
         uX/2EbGEtJAfdr2L1EotZaOBtF7qjNIJBYOMfp4JueC6QRE5b1+p2OUdwo4tbxKpahnG
         me8R+6IrxqQhD3tt/lR0lxkNq7oGgWR2DgRMZDJJGzFoZEo4AfVJE6EvyBWGXPEpidc+
         z/sQ==
X-Gm-Message-State: AC+VfDwerTsJrvIKOKkcESQxlT8Aj6PVnroIjDwdf4ZFWH0z7dR45DFT
        XCCAgP5XugX2AtYU9uCPdWNYRQ==
X-Google-Smtp-Source: ACHHUZ5y1saTqsWRD5lKY3DfBma0oCNPx8Yo7rLHR+umtawiVR8DGcUWb5J5pFrfL6M10DRtlR2reQ==
X-Received: by 2002:a17:902:d491:b0:1ab:26a8:5401 with SMTP id c17-20020a170902d49100b001ab26a85401mr31973723plg.31.1683822386770;
        Thu, 11 May 2023 09:26:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902bb9100b001aaef9d0102sm6120820pls.197.2023.05.11.09.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:26:26 -0700 (PDT)
Date:   Thu, 11 May 2023 09:26:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        linux-hardening@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dlm: Replace all non-returning strlcpy with strscpy
Message-ID: <202305110926.4A833D9@keescook>
References: <20230510221237.3509484-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510221237.3509484-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 10, 2023 at 10:12:37PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
