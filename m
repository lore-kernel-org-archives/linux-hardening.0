Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB171B264
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+LO7eJ8"
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BD2B9
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 10:29:27 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-692779f583fso3210882b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 10:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696872567; x=1697477367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xmOFJ7BPS0CGwUS7ZxzIQam3KgDjrxQW8SgccLQm/wg=;
        b=W+LO7eJ8NduQhx2ab6yej00MuKZEMBVFNWOA1bgBDXr4JtClsqXJMmUfcmdhqSN53M
         uoeDjownN2FPtlyFRi0yd+dRy7P+BoAxwB1Ppps/92TJi4sLYl3MOa2CTpAmjnFZhGqV
         ai9SGZJl5n9BpTmZd5B0cyLb8P/6YSsvIy4fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696872567; x=1697477367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmOFJ7BPS0CGwUS7ZxzIQam3KgDjrxQW8SgccLQm/wg=;
        b=pPyDpwPmBUpWzQbSI6K4/4q/0wuWUd4udFHq04yMZJ4vtiI4T0I///ZppBAaokLiUR
         GmA6XARLnbQv5KcfefaeHmYey+85T3fcnpdV2N3Ju2wj2aGyUQMeSGmyPDf7+3kcOhLL
         LAD88GwKF6zyGcUgijsIdmfj2/Fj1sbkZAwlBEc3O5pYPuUAKLvHP+KY4OiXzlSf3zv0
         nN44DX5BkMSDL5V2R2340suvDVv2W95XCmBmr5T5XnfQVbeqxXcnZSkPVEnjLgPfBI62
         jlsKpRACO6LBPXYMFSlF64eDytI860BdHoKwv+0VP6y4xHtwxOMz6gR95h6QUAGOblm+
         HP1g==
X-Gm-Message-State: AOJu0Yz2k6uLwImK+fleob5ck/L/c0gBlmodtOsL/h/xOYwjfGNi/sxo
	Fcd4lXAUie8Y/FOpnkgRdixvHg==
X-Google-Smtp-Source: AGHT+IGZBkYyLr1mAtcevkwX0r0BAUIUeuDmh/qvFnx7ofbkwmEk9cxHjoRpI21wTaFaYWBooUAtNQ==
X-Received: by 2002:a05:6a20:7f9a:b0:140:a25:1c1d with SMTP id d26-20020a056a207f9a00b001400a251c1dmr17552800pzj.51.1696872567107;
        Mon, 09 Oct 2023 10:29:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i73-20020a636d4c000000b0057c29fec795sm6126977pgc.37.2023.10.09.10.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:29:26 -0700 (PDT)
Date: Mon, 9 Oct 2023 10:29:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Nick Terrell <terrelln@fb.com>,
	syzbot <syzbot+1f2eb3e8cd123ffce499@syzkaller.appspotmail.com>,
	clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	linux-hardening@vger.kernel.org
Subject: Re: [syzbot] [zstd] UBSAN: array-index-out-of-bounds in
 FSE_decompress_wksp_body_bmi2
Message-ID: <202310091025.4939AEBC9@keescook>
References: <00000000000049964e06041f2cbf@google.com>
 <20231007210556.GA174883@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007210556.GA174883@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 07, 2023 at 02:05:56PM -0700, Eric Biggers wrote:
> Hi Nick,
> 
> On Wed, Aug 30, 2023 at 12:49:53AM -0700, syzbot wrote:
> > UBSAN: array-index-out-of-bounds in lib/zstd/common/fse_decompress.c:345:30
> > index 33 is out of range for type 'FSE_DTable[1]' (aka 'unsigned int[1]')
> 
> Zstandard needs to be converted to use C99 flex-arrays instead of length-1
> arrays.  https://github.com/facebook/zstd/pull/3785 would fix this in upstream
> Zstandard, though it doesn't work well with the fact that upstream Zstandard
> supports C90.  Not sure how you want to handle this.

For the kernel, we just need:

diff --git a/lib/zstd/common/fse_decompress.c b/lib/zstd/common/fse_decompress.c
index a0d06095be83..b11e87fff261 100644
--- a/lib/zstd/common/fse_decompress.c
+++ b/lib/zstd/common/fse_decompress.c
@@ -312,7 +312,7 @@ size_t FSE_decompress_wksp(void* dst, size_t dstCapacity, const void* cSrc, size
 
 typedef struct {
     short ncount[FSE_MAX_SYMBOL_VALUE + 1];
-    FSE_DTable dtable[1]; /* Dynamically sized */
+    FSE_DTable dtable[]; /* Dynamically sized */
 } FSE_DecompressWksp;
 
 
And if upstream wants to stay C89 compat, perhaps:

#if __STDC_VERSION__ >= 199901L
# define __FLEX_ARRAY_DIM	/*C99*/
#else
# define __FLEX_ARRAY_DIM	0
#endif

and then use __FLEX_ARRAY_DIM as needed (and keep the other "-1" changes
in the github commit):

 typedef struct {
     short ncount[FSE_MAX_SYMBOL_VALUE + 1];
-    FSE_DTable dtable[1]; /* Dynamically sized */
+    FSE_DTable dtable[__FLEX_ARRAY_DIM]; /* Dynamically sized */
 } FSE_DecompressWksp;
 

-- 
Kees Cook
