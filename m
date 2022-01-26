Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E812DC63682
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 17:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbiAZRau (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:30:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43708 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbiAZRat (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 12:30:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5F36B81F83
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 17:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CE8C340EC;
        Wed, 26 Jan 2022 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643218247;
        bh=Ze5fXt4FqL+Zh8NP0MNCtrp81vRDih6UzTPz+louRs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdCg8Kzb9oSI2Kbc9wKA1SmuNtjNGvjuPuYt7zrQ3HFQAlTG1SACXpQLBOdUMb7qy
         2GybdCNMdnBHtvHhGbZPlKLrET3OPwQV46/7WYmgl9fI+Utu5mO46LGOHT+JmG2fv0
         lihQHGHDyX5+BZDy2LQV512mCLIn51JLy8A4uzymM/7rSXBYGwwBxZFHNGU7traTGL
         AadcY6LDicxQlZsqQgVsGp3M2lAWy5TNrgTmsUeuIzRR3zonW3PIECcWrNUVJ1HX3T
         r8ktreOFgw5OVLfRZvxzXQBdfAoYbAU7KvSF/2vcBs6d1rdy5izYDD/PB/aWi+65Gi
         SJDT5PNeFqS6w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, linux-hardening@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Quentin Perret <qperret@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH 10/12] mm: add default definition of p4d_index()
Date:   Wed, 26 Jan 2022 18:30:09 +0100
Message-Id: <20220126173011.3476262-11-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126173011.3476262-1-ardb@kernel.org>
References: <20220126173011.3476262-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; h=from:subject; bh=Ze5fXt4FqL+Zh8NP0MNCtrp81vRDih6UzTPz+louRs0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh8YUfVBEGUydkFMtp/h/I8kciukE+cFuRdfFb2fky AhRgWCaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYfGFHwAKCRDDTyI5ktmPJLD/C/ 4yQahFWNFa/1tH/H8r8S9y5RIYb0h5NS5hECeNvEcWyO7oRnqbY3f5zbn+klgL2I48RSBQteEhW1+d 7NmRJi4E06iZljwX6ZuQdIGXbgfOuwzJ+VQWr5b7JUnoXtSobUuPQgMywf8bBOja6SQSgLRDVopxtL Yi7VR77F2T8ODmx0pGhDHZaD4mgiS2tfiIkUEGnqyTRRpUqKUDWq0yI+1ZLl+UXeAKlmM8qNAdLQWp hZdtN4RiyflFFlqdgCuMtEERZKl7+dgTnMj/iOOysP/dtDCFLVtVqq5C8FPQGz0KIL0o4DcsZBOuTA 09M/Fs2SU+gBljG8scV935cZVm0ZXgsoOTjwDCC7i8GlsmeBcQnZfdVGDaSnt5qzJNoyNQ+g9yEOqV W3BNZdqg7gIRWk0LP8Sx3J3b8b7TPKdaHMgk+BxPoEo6UqxEqR3dsbvOSnoRtZqSRkPDljDsjCiUvf xfkilXxzgrsuGpGIA1D1fKBx1NjppgccTkYXJMS7J0zFs=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Implement a default version of p4d_index() similar to how pud/pmd_index
are defined.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/pgtable.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index bc8713a76e03..e8aacf6ea207 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -79,6 +79,14 @@ static inline unsigned long pud_index(unsigned long address)
 #define pud_index pud_index
 #endif
 
+#ifndef p4d_index
+static inline unsigned long p4d_index(unsigned long address)
+{
+	return (address >> P4D_SHIFT) & (PTRS_PER_P4D - 1);
+}
+#define p4d_index p4d_index
+#endif
+
 #ifndef pgd_index
 /* Must be a compile-time constant, so implement it as a macro */
 #define pgd_index(a)  (((a) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
-- 
2.30.2

