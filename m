Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ADFEB64DD
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jun 2023 20:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjF1Uwz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjF1Uwv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jun 2023 16:52:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DC01BD1
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 13:52:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66f5faba829so160297b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 13:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687985569; x=1690577569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzojRQ1F0egJqRD59S+FcTqPfQzuWDtOgop6JLdMSGw=;
        b=HiZCgsxp983FQwUw2sx6AdlekN/G/snxYdNfXGidR0MDb7jLkQBBFNFwLrGSrQ8Glp
         fERHuElJlAG+HKiB7tDmZFk/hlwsXHeyhKiUZZa+VaBQhdTP1LUiOQJN4XErfGNoIihl
         oMBaNPGR0mKrDczhcQ9qXSMBEhdHf7Gy6/UQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985569; x=1690577569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzojRQ1F0egJqRD59S+FcTqPfQzuWDtOgop6JLdMSGw=;
        b=C0H5UqVUyxItUpmvaDB3yAwCU7laAubeoRwkHcE71LrJntQl5jbHxbOKndJbOmyqI9
         fL93Hz2YD5vYJ6LpbxNXFPaAcj0ra1ATmdbbHhC98v3MMP/4SC51unjJqY0F7gDUccGV
         hM8jySdA/BHVtWSjFxhh/I8pCPrSfVR/pDtDUhTzCXcz6SCcOlQmpj6Fj2ixIGxFpMtf
         1lT68uR1QCLloBWW/73y5WuebAnBEds7o0bZEFxC9vY6BdgiNuGd9kVwnJaL3gzghcqH
         x13nGrBa5I+5QUGZ3PDS/dHGO9xOqUcnLEKXgGMvkHGnEguJpjXpGePhyVS6T49fTi1B
         16Eg==
X-Gm-Message-State: AC+VfDyucoCWNdEkRTXc1wcbvLvqYBpbogjJUle8i5raGBFyJpxi/kDV
        9++aIi+gONCsvW5aL3fVIebNoLokJeoRrMErgMw=
X-Google-Smtp-Source: ACHHUZ6aWKbpdlWdbqo0UZTOBgabSUelUcGn6RoJQGsfCDv2XWMn23NkmZOmuIik8ez8Eq2+BIMQaA==
X-Received: by 2002:a05:6a00:2341:b0:680:98c:c58d with SMTP id j1-20020a056a00234100b00680098cc58dmr4879003pfj.2.1687985568796;
        Wed, 28 Jun 2023 13:52:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b0064378c52398sm7355134pfn.25.2023.06.28.13.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:52:48 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:52:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 06/10][next] scsi: aacraid: Use struct_size() helper in
 code related to struct sgmapraw
Message-ID: <202306281352.815ED6569@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <be2e5ecf1c4410ab419e2290341fbc8a0e2ba963.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2e5ecf1c4410ab419e2290341fbc8a0e2ba963.1687974498.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 28, 2023 at 11:56:31AM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions.

Oh, I think you can add two more patches to convert sgmap and sgmap64
fibsize calculations too.

-- 
Kees Cook
