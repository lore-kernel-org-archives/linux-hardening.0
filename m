Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDDDEB64DD
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 06:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348153AbjHQGJY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 02:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348142AbjHQGJE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 02:09:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE951987
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 23:09:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-26b47df332eso2513304a91.2
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 23:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692252542; x=1692857342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMupaGt3lT1C6kccf/TFi4L2Zf/EmehC3TxUCzjtixY=;
        b=FFPr75vKB+KpdBAwp2C3sgFtlfEVnChZG2+NKIhPJx2xbiWQe0rm+3eqQSt1ZYcesi
         YDMGMDtYR0328TGSOOy9F6RBFp4sQTgKJ0o+zGtaB+LO1awcFO7S/v/xpuKr4YSTwbz4
         VmOhac0ElSZ3hkkkPRHVATGDKuXniBOBMc39U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692252542; x=1692857342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMupaGt3lT1C6kccf/TFi4L2Zf/EmehC3TxUCzjtixY=;
        b=KD9GdHyFBM9EV+VF6erAkkwZAelKeMWSm8KG4KNhPZP1n97YedEQ3vBOI/M8a4seyZ
         nN0PfxHhVq1qlo/EFLLDgoFN23aZ/94WaPmAxJqNmijPpLk6WbvN1PDpbWrU7SFl4SKX
         MoFjcdWgahLiO7uYWI8n5A/JlpPskV93bQyZQMR+htR8EyN5rmv2bU1+/qUB9Sm18WfI
         zuhH3qElwntXdZAn9hqVtq9NgEz0OSbUhhfFr76k4+zXOoosuH721bQmrFIerBtAlH1H
         +Cxr2ZWPw+mBBAeBDD6H8aKy9/FnyH1hOHiuma7C/gC0nJ3QManrm4bTIv594J7xq5yn
         +rCA==
X-Gm-Message-State: AOJu0YykFQUJdukiiM5gEqi2v+wF8AfriPP7rNzewpRcB4tiExYEZroK
        EQ9X347mAbWQw0N9QtNS8NgdODuY6OIehWsHLjA=
X-Google-Smtp-Source: AGHT+IG3QbcrpDrZ9Ru2n1cwj5LDSCPZgsOvfI1WKSbQd51Qm63XNFI7JaPbVv68FFkX9s/qIOWYLA==
X-Received: by 2002:a17:90a:990e:b0:268:6670:46df with SMTP id b14-20020a17090a990e00b00268667046dfmr2987411pjp.27.1692252542365;
        Wed, 16 Aug 2023 23:09:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a031b00b0026d034f6badsm815035pje.38.2023.08.16.23.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 23:09:01 -0700 (PDT)
Date:   Wed, 16 Aug 2023 23:09:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        linux-hardening@vger.kernel.org
Subject: Re: [netfilter-nf-next:testing 2/9]
 ./usr/include/linux/netfilter_bridge/ebtables.h:163:26: warning: field
 'target' with variable sized type 'struct ebt_entry_target' not at the end
 of a struct or class is a GNU extension
Message-ID: <202308162257.F7876776C9@keescook>
References: <202308171249.g1ywxhII-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308171249.g1ywxhII-lkp@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 17, 2023 at 01:03:20PM +0800, kernel test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
> head:   015e2d9101d3713c7bee16dccad171df04a3bbd5
> commit: 61b9e6bd48a6317c0a44ee4f3fecdec9de5baa9e [2/9] netfilter: ebtables: replace zero-length array members
> config: i386-buildonly-randconfig-r004-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171249.g1ywxhII-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171249.g1ywxhII-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308171249.g1ywxhII-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from <built-in>:1:
> >> ./usr/include/linux/netfilter_bridge/ebtables.h:163:26: warning: field 'target' with variable sized type 'struct ebt_entry_target' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
>            struct ebt_entry_target target;
>                                    ^
>    1 warning generated.

Eww, it looks like "struct ebt_entry_target" is used _within_ another
struct:

struct ebt_standard_target {
        struct ebt_entry_target target;
        int verdict;
};

So "verdict" overlaps with the "data" FAM:

struct ebt_entry_target {
        union { 
                struct {
                        char name[EBT_EXTENSION_MAXNAMELEN];
                        __u8 revision;
                };
                struct xt_target *target;
        } u;
        /* size of data */
        unsigned int target_size;
        unsigned char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
};  

These have been fixed in the past in a variety of ways -- it all depends
on how userspace is using them. In looking at Debian Code Search:
https://codesearch.debian.net/search?q=struct+ebt_standard_target&literal=1

It is exclusively doing casts and looking at the "verdict" member. So
the easiest conversion might be this:

 struct ebt_standard_target {
-       struct ebt_entry_target target;
+       unsigned char hdr[sizeof(struct ebt_entry_target)];
        int verdict;
 };

Or this might work (not tested):

diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
index a494cf43a755..d6f10163b14a 100644
--- a/include/uapi/linux/netfilter_bridge/ebtables.h
+++ b/include/uapi/linux/netfilter_bridge/ebtables.h
@@ -146,23 +146,25 @@ struct ebt_entry_watcher {
 };
 
 struct ebt_entry_target {
-	union {
-		struct {
-			char name[EBT_EXTENSION_MAXNAMELEN];
-			__u8 revision;
-		};
-		struct xt_target *target;
-	} u;
-	/* size of data */
-	unsigned int target_size;
-	unsigned char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
+	struct ebt_entry_target_hdr {
+		union {
+			struct {
+				char name[EBT_EXTENSION_MAXNAMELEN];
+				__u8 revision;
+			};
+			struct xt_target *target;
+		} u;
+		/* size of data */
+		unsigned int target_size;
+	};
+	unsigned char data[] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
 #define EBT_STANDARD_TARGET "standard"
 struct ebt_standard_target {
-	struct ebt_entry_target target;
-	int verdict;
+	struct ebt_entry_target_hdr target;
+	int verdict __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
 /* one entry */


-- 
Kees Cook
