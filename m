Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3O79Cw8"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40836182
	for <linux-hardening@vger.kernel.org>; Mon, 27 Nov 2023 23:24:35 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cef61289fdso45140837b3.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Nov 2023 23:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701156274; x=1701761074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hL9Tqag7AJX6zAdbbkbaDwLX0iVjHOEY+HYssYNlBSs=;
        b=R3O79Cw8aWGA1Ko2Wlpc7FUaut6rEhvk3H35RBLLYZqFbPxBL3pU8Q0gTRsoUhnH8Z
         odE5pA+ErI5frmKIGo2WNviooWT9caTN/vNtcclMttrIS3k9rn+WiTqcwH5xODKd3Z6a
         c8DlSj+6t7PR7zsE9yZWnCCswQT5QqzcnAbQd2dwIu5r/3z9YPCs2LdZVumjKq5xedDz
         4NXI2jz71GhRJBN5Wl2j3Ggo/sQcBqmipjCNQFWMnCh1dRumkxhXMwY2u14EA8/GkXah
         nuDbZB1+MAbNUpxf6TEC2lVi2BqAF9I/RdQDxC4/NlEcYJpcDBXDcYa+zlkvHFVzmVE2
         /mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156274; x=1701761074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hL9Tqag7AJX6zAdbbkbaDwLX0iVjHOEY+HYssYNlBSs=;
        b=buN/yb18kj4U6DyBlEiWS/OjEVUZKp2+pg6+hfczj1vEYuhHR/fo/IsLjQIlm7R53N
         tD3LV2ToxAe22KucExbB1o3pzZunwX2lOtX0jsoZ3cAlccGenltvT/+UE0RCydy6OxUu
         YG5vuMPWrTX8aP/+ggHjDsdhDJTvsCVgAGHf6Ve9dd8ATpLgg5H08kw7qmouU1oTaxpr
         AzIEjlKkZGQjTk56uIpjNtKKhSCGeKICt5VohFoVFSUMwBYbW11y5mMgvhSMlvEoUehI
         pwfQdyzbKIScTgWP0/embVB/OP9DWZ1RIkan2PG9+PWHBR73CWvLSnSIJsbelNrAno89
         pVhQ==
X-Gm-Message-State: AOJu0Yw9d7XbdcoZxVaznbjgMHyF0eM0BpkbxPHcBgv6y/fWKo8OCjfS
	OC75LEYeIEEujMMrakY1J9RLaARr6sK3bA==
X-Google-Smtp-Source: AGHT+IGoRIHKr3JyrbM3tkKrf0PmKkWlRFIRiSnxD6FAHnrPxKsZM4C/FRkjkDW0SuhziYxtsE89EeXxGNnLEA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:3741:0:b0:db5:2a4:aef1 with SMTP id
 e62-20020a253741000000b00db502a4aef1mr30191yba.13.1701156274525; Mon, 27 Nov
 2023 23:24:34 -0800 (PST)
Date: Tue, 28 Nov 2023 15:24:07 +0800
In-Reply-To: <20231128072410.952662-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231128072410.952662-1-davidgow@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231128072410.952662-3-davidgow@google.com>
Subject: [PATCH v2 3/3] drm/vc4: tests: Use KUNIT_DEFINE_ACTION_WRAPPER
From: David Gow <davidgow@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, dlatypov@google.com
Cc: David Gow <davidgow@google.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Richard Fitzgerald <rf@opensource.cirrus.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"

In order to pass functions to kunit_add_action(), they need to be of the
kunit_action_t type. While casting the function pointer can work, it
will break control-flow integrity.

vc4_mock already defines such a wrapper for drm_dev_unregister(), but it
involves less boilerplate to use the new macro, so replace the manual
implementation.

Signed-off-by: David Gow <davidgow@google.com>
---

No changes since v1:
https://lore.kernel.org/linux-kselftest/20231110200830.1832556-3-davidgow@google.com/

---
 drivers/gpu/drm/vc4/tests/vc4_mock.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock.c b/drivers/gpu/drm/vc4/tests/vc4_mock.c
index 63ca46f4cb35..becb3dbaa548 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock.c
@@ -153,12 +153,9 @@ static int __build_mock(struct kunit *test, struct drm_device *drm,
 	return 0;
 }
 
-static void kunit_action_drm_dev_unregister(void *ptr)
-{
-	struct drm_device *drm = ptr;
-
-	drm_dev_unregister(drm);
-}
+KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_drm_dev_unregister,
+			    drm_dev_unregister,
+			    struct drm_device *);
 
 static struct vc4_dev *__mock_device(struct kunit *test, bool is_vc5)
 {
-- 
2.43.0.rc1.413.gea7ed67945-goog

