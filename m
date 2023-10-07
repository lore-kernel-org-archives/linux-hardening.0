Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FB01842
	for <linux-hardening@vger.kernel.org>; Sat,  7 Oct 2023 04:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="glsiKpdJ"
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2462FBD
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 21:12:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c737d61a00so22499945ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 21:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696651929; x=1697256729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZXl4fZOZGW6S4QLpiluo7ub/jMSf5d18x41Dh4pVsY=;
        b=glsiKpdJrZmJ4caPvGoW8B8n5fHOLSiFIRfOe89tE9+yCuoNSBld1/sfbWTb8CKmPc
         cPEzKfD+XlsLkRD9F9hMv3PASOeYRgvWPhBQupzWddxH4zeQvKtzhmNHiP1Ak+KEMqW4
         XWjtj0aF0/Ltkm2Uw0Ac0u8yJVwMayWdGbucA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696651929; x=1697256729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZXl4fZOZGW6S4QLpiluo7ub/jMSf5d18x41Dh4pVsY=;
        b=YRNInbVCMUJjZ6dX6fobygb+1dPwY/hwD3vq0da4xcXlAOw9RC5vex62zWggzLKpsT
         7Yx0jEsZe+230VWr54vxJEyU05UV75UVRqcLEMpWoEopRORbV0fDOOYYA3drSFOeVHHL
         n5M1ZPf2Pd5EVRYcfGbrdUOQ6ejUgXgnbdWCfV1B+Yb6lfELpElLbi765zdBa9ZT0k4c
         cx7HZNnTv1VnkIYCEQF13uhEdXkhcvvt1BBn2gu6Mu1lpZXgZ2g8ObKY8Wg8HenemvPl
         YjA9VboRWhHRMA2JPgNXjMn6xyf/3iywHLq/ex7IGTSC/n3NZ5ESYsaK5pmfEQ8WeW7e
         gEYA==
X-Gm-Message-State: AOJu0Yz1nmsjbdjIv4a6bW4LqSV7qrhrWqpSV9VtvJr9poYDwzy4T9fo
	HCQlZRsVUsGAiU+RbIoT8X6r7w==
X-Google-Smtp-Source: AGHT+IF/ZipK2R7tGfd625n03Z25S787onFBu5JyqaUiGZOKjSrX04s0bRLQ8heHgUE/EU7Spolwug==
X-Received: by 2002:a17:902:e749:b0:1b8:76ce:9d91 with SMTP id p9-20020a170902e74900b001b876ce9d91mr12712347plf.1.1696651929605;
        Fri, 06 Oct 2023 21:12:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ju8-20020a170903428800b001c72d694ea5sm4757330plb.303.2023.10.06.21.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 21:12:09 -0700 (PDT)
Date: Fri, 6 Oct 2023 21:12:06 -0700
From: Kees Cook <keescook@chromium.org>
To: Lukas Loidolt <e1634039@student.tuwien.ac.at>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Marth <daniel.marth@inso.tuwien.ac.at>
Subject: Re: Missing cache considerations in randstruct performance feature
Message-ID: <202310062111.809AB4E56@keescook>
References: <f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 07, 2023 at 12:30:01AM +0200, Lukas Loidolt wrote:
> In my tests, however, the performance version behaves more or less like the
> full version of randstruct.

Can you try this patch?


commit d73a3244700d3c945cedea7e1fb7042243c41e08
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Fri Oct 6 21:09:28 2023 -0700
Commit:     Kees Cook <keescook@chromium.org>
CommitDate: Fri Oct 6 21:09:28 2023 -0700

    randstruct: Fix gcc-plugin performance mode to stay in group
    
    The performance mode of the gcc-plugin randstruct was shuffling struct
    members outside of the cache-line groups. Limit the range to the
    specified group indexes.
    
    Cc: linux-hardening@vger.kernel.org
    Reported-by: Lukas Loidolt <e1634039@student.tuwien.ac.at>
    Closes: https://lore.kernel.org/all/f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at
    Signed-off-by: Kees Cook <keescook@chromium.org>

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 951b74ba1b24..178831917f01 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -191,7 +191,7 @@ static void partition_struct(tree *fields, unsigned long length, struct partitio
 
 static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prng_state)
 {
-	unsigned long i, x;
+	unsigned long i, x, index;
 	struct partition_group size_group[length];
 	unsigned long num_groups = 0;
 	unsigned long randnum;
@@ -206,11 +206,14 @@ static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prn
 	}
 
 	for (x = 0; x < num_groups; x++) {
-		for (i = size_group[x].start + size_group[x].length - 1; i > size_group[x].start; i--) {
+		for (index = size_group[x].length - 1; index > 0; index--) {
 			tree tmp;
+
+			i = size_group[x].start + index;
 			if (DECL_BIT_FIELD_TYPE(newtree[i]))
 				continue;
 			randnum = ranval(prng_state) % (i + 1);
+			randnum += size_group[x].start;
 			// we could handle this case differently if desired
 			if (DECL_BIT_FIELD_TYPE(newtree[randnum]))
 				continue;

-- 
Kees Cook
