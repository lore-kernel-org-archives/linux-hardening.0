Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42266C43217
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Nov 2022 03:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKIDpt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Nov 2022 22:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiKIDps (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Nov 2022 22:45:48 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3B71571D
        for <linux-hardening@vger.kernel.org>; Tue,  8 Nov 2022 19:45:48 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p21so15940274plr.7
        for <linux-hardening@vger.kernel.org>; Tue, 08 Nov 2022 19:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pnMg2Hpw6/iJzd3FM2wY8v5EWPbAWF9J3lAMqPkfldo=;
        b=IBalqdBg9Jf+M2TCfV5GNefgRsipVGvyqMHgtq59bQctNW+pZ9E0KeYLmoDocmljBt
         JWoYE2AuK+1g1Nr/BsYvyM+4IpxVVdur4sB/z4ZGrOUxq1sksMKFJ8mMaP+A8M1TrBXL
         VM5oIwA3uvbtXSmEHRke454Jn6lM3st6HE3w2uZW6nJV6WP25ja5m4Ro6z6/A5pxhxpl
         4t+uzOsVtITcDHtP3zffCRDjM9OF2xMKzrELCJ9HxHJ3fZ3eYIkR0w0qGpxTebHDvAD5
         4xGBByLMMxw2cyW+B52MRNZgDgmatYKOA0VRIrQV4aQbumXGwQMy4KnqjPzlpZKj8UFK
         7B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnMg2Hpw6/iJzd3FM2wY8v5EWPbAWF9J3lAMqPkfldo=;
        b=fDHRTve/YdVtEsDuBTxTQ+Ux0QB2CXlVxVUDytoeZhRf3AO/azoaSyLThS+QwgF6ZU
         4j5/gLvx95YLFdSNlF2ktdVkqYmbUsz9csCB1Y4e2q16VDYuzlQBiMaeqJ1EOcHhVJ4u
         SWb9rtJi8ASnGuaIlFsSMFl93zl3rxoYPjP39TrTMZ5LKG8JPoEcsiQjWjgVB1qTgO0Y
         A1ox1+7L4+6GnpzWo7GM0qHENCK731bw8QoFtXG4iW0CgCZMupLIxyPipcXBGmTjvNj3
         pYOmaNCYiOhw4JFgYBT42kL1QN2dssRHQMhDqSVTYGVLWJRpgvscwD/pT8cHqdU/clCQ
         WfVg==
X-Gm-Message-State: ACrzQf3qhdBwWr06mbbHSd8lalGv8rz+hYO8a5lCrGyL9cRbaZSIcjOy
        MSJwGacYYCat3uJ+qzd5/AsJvnCh/FGbatUD
X-Google-Smtp-Source: AMsMyM4UChEr3gBlmSu7UQ1IG/FTAC1V/ic63iMzUUWW7mFp+jWNbdhNfy5cnvG0opS1ZRwqBD4wXA==
X-Received: by 2002:a17:902:d48a:b0:187:2b1d:10e2 with SMTP id c10-20020a170902d48a00b001872b1d10e2mr46597584plg.86.1667965547232;
        Tue, 08 Nov 2022 19:45:47 -0800 (PST)
Received: from mail.google.com (125-237-50-34-fibre.sparkbb.co.nz. [125.237.50.34])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902bd0c00b001754fa42065sm7741411pls.143.2022.11.08.19.45.45
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:45:46 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:45:42 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     linux-hardening@vger.kernel.org
Subject: [RFC] Approaches to deal with a struct with multiple fake flexible
 arrays members
Message-ID: <Y2siZmiTD40mTYpJ@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi KSPP community,

I've been working on replacing 1-element arrays with flex array members
on the drm/amdgpu files. I came across one insteresting case which I
may need to pick your brains to find a solution for it.

The structure below has two fake flexible arrays but I would get an
error if I try make them both FAM. How should/could I deal with the
asRegIndexBuf in this case? In theory, DECLARE_FLEX_ARRAY would "work"
but that doesn't seem to be its intended usage as far I've searched.
(unless I got it wrong, if that's the case, feel free to set me straight)

Any ideas? 

struct _ATOM_INIT_REG_BLOCK {
	USHORT                     usRegIndexTblSize;    /*     0     2 */
	USHORT                     usRegDataBlkSize;     /*     2     2 */
	ATOM_INIT_REG_INDEX_FORMAT asRegIndexBuf[1];     /*     4     3 */
	ATOM_MEMORY_SETTING_DATA_BLOCK asRegDataBuf[1];  /*     7     8 */

	/* size: 15, cachelines: 1, members: 4 */
	/* last cacheline: 15 bytes */
} __attribute__((__packed__));

thanks!

- Paulo A.
