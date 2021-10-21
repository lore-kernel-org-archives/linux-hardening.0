Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22975C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 15:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017DD611C7
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 15:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhJUPnP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhJUPnM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 11:43:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B66C061764
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 08:40:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so3440902pjl.2
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bjoPyXkr6BV0dE+yUHbVGsg5Kch/RG6+gsn2Vg2w1gY=;
        b=QRFnssmAHusAf4AsyE7xykM+jeNm9TVbcBZny5z+0bOEBkq+F8VjAWk5lEOfVtxJK/
         n+L3vNRort1jo76UzuAQGb5iya4i1ZbsZjfSyR0zsdL5WZW4pic4D3G5AY1gFD5YxZvk
         /7QYO+7SEOASn1Gu/e04XZ5/xRPpUQCFFrB1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bjoPyXkr6BV0dE+yUHbVGsg5Kch/RG6+gsn2Vg2w1gY=;
        b=L7MaJuCxjI4iFeidVODLPhsGRK+fzYXFepG2zA0qfqtqH9G6ndV92a9zbn9drKfTMw
         GB1Vbo/dzjEGgA0/PqTJfuAzPwS4QOxUgSFKaCPTpFaeo9F7kwomiufTkVdDd0ZI2Q7K
         fCgHlOu0VaU8BqH15wZW4aN92BX/iTM0JJD07VXrDhau5WZPiZI+pwII23q58d/e0Eka
         YcO3LIesile5/PNWxNMXLGXbPEoM4f1t6YrG72YKsRrVEb11nP+LMHI/VrjFcF+mIBsa
         HsSOJVwse0wj1tJxJsg+IXo0VCFSqNA94ZgyAQ813shJ4bd7A1IFZBQUB/KTn/qpN6mu
         HogA==
X-Gm-Message-State: AOAM530zcZeY+SJDAO8KUfnRTyc1NH0SrqhTkNKVI+y/8ZOa+Ea3FtWb
        7/IF1z6qlYYt6RCGNYEdF0AGCA==
X-Google-Smtp-Source: ABdhPJzOFte7SFD509WcWquMBljCqJbCjwmI95RIMLhDJ5FRtlRaMsLEHs4ZoY7vKNyHC63290orug==
X-Received: by 2002:a17:90a:b314:: with SMTP id d20mr7490963pjr.174.1634830856276;
        Thu, 21 Oct 2021 08:40:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d23sm6260334pjx.4.2021.10.21.08.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:40:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Mike Rapoport <rppt@kernel.org>,
        Jordy Zomer <jordy@pwning.systems>, linux-mm@kvack.org,
        Dmitry Vyukov <dvyukov@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] mm/secretmem: Avoid letting secretmem_users drop to zero
Date:   Thu, 21 Oct 2021 08:40:46 -0700
Message-Id: <20211021154046.880251-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; h=from:subject; bh=2je4tCGogJs5O0M1a6Owc8LlmksMf1YAds2mqYCwhPk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhcYn+VjVqfZ1g4oxjbETXXpGe3Wzs/9s8ZXeqpwO1 lxxXjO+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYXGJ/gAKCRCJcvTf3G3AJi/wEA COl1Z2nPbM2KnDN3X3n3/Xxdip10rRV7AOHHMPthSbxZ/5I2fACRIb0D1OjsvkvC7LBj6GmL497HOw afsHGtdAO0GH6BOZWbjcdMCUQUOJny/JG78+aTE1aNnxRzBXkr+zuBhG7fL9evc/8y9W+9p8hcB1kf /NsK8T1B9LDWnMXLdkpkEpn0dVumR0cZPGwCmtHAAJqU1HkAZ45tdTplysKlsZ6zqIMqZr4qcVdllD YyRMYdWal6Z4mTFn0PI7DDgsUynCaISVHfQ7e/2J+YDYhvwrgnaAphPIzssE3lxSN4qhCXQtKYqBOt ekqfk3K1i73BaK5Y6irkW106FV/aPZeldUXza3hJILhdj7ekAl0RMvbN1WNMpjOKJB4rHGJAKI+LJK 4Qaz5ye43sDP4OJgYy79/jzE3HZqtt3rj9eApTaGmNNTTQsko45e7XZLEgv4XvpRpOi34PyJORqyIE Aot/QBbq/dld2vxDkWJ+XDKXp23PFRUTr74bgQXjhIiKZ+HC0/BLzpgy3w8V3Rme+4/UrXJlL2i3KA ZBLrYGGrACDoaZWY+rbJ0Cz9sEUJFP2MOldX5ev8zy+4u+dzMFRaq/BOJ0b+5TJo1yy4iOxhf7r3eX yfRPrjyHHAM/+sT5TeZcCFKsA6CtI1itMszhzVxZJTfSpil+YECIzXq0Xz7g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Quoting Dmitry: "refcount_inc() needs to be done before fd_install().
After fd_install() finishes, the fd can be used by userspace and we can
have secret data in memory before the refcount_inc().

A straightforward mis-use where a user will predict the returned fd
in another thread before the syscall returns and will use it to store
secret data is somewhat dubious because such a user just shoots themself
in the foot.

But a more interesting mis-use would be to close the predicted fd and
decrement the refcount before the corresponding refcount_inc, this way
one can briefly drop the refcount to zero while there are other users
of secretmem."

Move fd_install() after refcount_inc().

Cc: Mike Rapoport <rppt@kernel.org>
Cc: Jordy Zomer <jordy@pwning.systems>
Cc: linux-mm@kvack.org
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/lkml/CACT4Y+b1sW6-Hkn8HQYw_SsT7X3tp-CJNh2ci0wG3ZnQz9jjig@mail.gmail.com
Fixes: 9a436f8ff631 ("PM: hibernate: disable when there are active secretmem users")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/secretmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 1fea68b8d5a6..924d84ba481f 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -217,8 +217,8 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 
 	file->f_flags |= O_LARGEFILE;
 
-	fd_install(fd, file);
 	refcount_inc(&secretmem_users);
+	fd_install(fd, file);
 	return fd;
 
 err_put_fd:
-- 
2.30.2

