Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687344;
	b=KHmCxXh0Ulry4hcdlCqBN4iNWb9By15f3j1PM2Rf/6cc+XLjaRqbvY0KS6xBTgSeqgCJ
	 ZJ1UMXwEqo/Hb2H5MHQqyUx+FSFyIkcQAaYBmM9X3qHTlRjaNxQkiMCdF8GlH7k2h3f4T
	 SixYWP5fvQO0aMGc8be3zpa/EgeeXZqS8HqdbNWRLgYeYvMgajuNtVdhKSSh8hWTFm56f
	 KqERYzPJzQ9XJ8lWMDio9C5cWLhAbtyUjwXwpnQU684FbgrXBaBeYINhWM2qO41BLbxY4
	 cfR5D0MJ2/RoysvcFyJS3SnJ1XozRfK5GbcS6J1S7H/6TpDdc24gVvqgBvFvLUeOM0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BpFS6ySbwG4J+0ZDYOqEgZMFTp6XLFpyMVM4kuMmIEU=;
	b=sRdBbVddsardz/VKpL0g9ZcbNG//792+qyUmx02JM4bXlSkvmEtUATzTgbtHnjYYtkVZ
	 v5mSZec1bS4q//cUIN5vGxRZpcydoY/kBdE6OPPUoIPv+gCkng/Q7I67e5wjWfYFbHUJ5
	 79IHPLaZ47qoPtCTGkgDTaJ34pcMICyHiZBjrn/ztZPJWrMySDjipUU0FMXzO82tZq7+U
	 B1RlPOdGfMn5u3QANazH+MnZyEKlBKNmKzUVvXZ86XPITBmWJ4Pa9qMMNDEKlCKyhyitq
	 Risr0iayp6I5XTGsiwEjdgAVQ3XggCaoNrsIUnXYq9HB6s131WkDPJqVhNHZ9n1kwnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Zly/bhuk";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187FC606A31E
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 16:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 187FC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zly/bhuk
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c4be28b82so1837536f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792687341; x=1793292141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BpFS6ySbwG4J+0ZDYOqEgZMFTp6XLFpyMVM4kuMmIEU=;
        b=Zly/bhukMS6FJUjJfT1eSqtaTbkAgukn20PNTV+vr3KX4kG2j6DGVJa+PChtvWhfPj
         cdXq80B0ssJ8Ip3qy11meFWs6jY7RkF8Q3FGJs5gDYEdqQkMSSk1U1wVUxeRl+ftO1Tq
         nRm0yyPMkb7PklYx0RwaGNe9HE7sn30WOkLhrgixmaTTKwS3TtkE4wVzTZ4SKrZAWMq0
         eUsrqrd0Poi1f29mM47ne04K55Z1jqBV6MAsAJqLEwAvSK0FBd0e9sBxl4q6jgKUpl2D
         BXHLa7GhF1owwciNJ9qIyfOxGvc90wf5zKVlJfOGde0GUKoIW7KJFz6j4uXKmyIVj+xd
         nJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687341; x=1793292141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BpFS6ySbwG4J+0ZDYOqEgZMFTp6XLFpyMVM4kuMmIEU=;
        b=0rPaqVoreAWHLhBiT7ucGq68ykw16S3xPrl1M7Ksu5aPEHM1sBwrOsVhLesKMjZnpC
         fAIrXBWn+IPQYMi0U9t9oxm1e7gVezX9buEo3/X7URtd8NsCXEJT/v4A65nsRV/bfh+I
         koSkK+3bPCmIxbCQqzBFR+uBOjyadkHqKJtTQa2jmnBJQq55diNe53JErId2GDtbYdY1
         1Zjpi7JcHHtAbDk3J2mrOH7YDSjGwxFiJoX1m+mHWFGyBhv4fmVxLQeEYm8eE22Wb87W
         YMsxqaOTCvLOcCdMB0avhxzHRRUaebROFV0kko2YtqkvdINTC0utFOKgXc/aZvI8DuuK
         JRxw==
X-Forwarded-Encrypted: i=1; AKwUvBwV/6XbpTy3UzGBde+1hPukYX7e+keGw2OgzVOZ7TuFZNa4SfLVSNIY5SR/ZxjJuNYrfjwQIHN8/qqWTWNcmlw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6TBe6OeFHMgFm2wB52k3+7pyvxka+Wnh4H+QU7leBFMmXsLAW
	f26tjL1Q7GdpkZpNM25sKYRG0dnENw2UTjNTuWRpuZOI7i7kF4gheLWB
X-Gm-Gg: AYBFou3cKqc05Ma1+ZZ19H2DMDsBKrMvFQ0YFcY6Sn9jdTfjAWESkEJ6z1TiHh7CEMQ
	CGrDHPly6xXnnRzL42UoufzhMz0AvL19K9XnMYTVVN9xDnGju7NgqCuSoo0hkZihezdk8Oi2aXI
	Dos6Q+tQgzsoDQjKXvN0Cn5TRqAEzNMGes0raOUY6VicGiGxN1Zx0Kz7x1SzNCWNMwkQVFY4x7G
	QS0OXKZzoB1v5jlId6C7IsYX/hdh7Llqpenqq/uHyRQoyAvEBOcsAhhF9dNHDy082nnbRSdqV3g
	rfkY+e1fHIFwCwE4IYIhLjSh1G6yfGTljkznz/jDLPKN3c/4jQzrTiKUtg574uJczb1XMFmC93c
	NgoX85TUghox5wlEvLfLLF+sxPewL554fW8YJiogyMxlfHo18/GN16KahIWgub7t9BcCPM2wf+K
	Yg6kGR2ScPHpPVGYHOyc31a6jootWJTBWMg6yFjQlK39qihGpOe7lhiNnT7FXDyEn02+TU6TqoY
	NJKSKUetWtx8tdv6hX3tuPxf5RSMYNHQhwIrgtYYWT4FzJV9vhMhPgDJyoyDp4xMer63LSMwR6M
	ccamyQ==
X-Received: by 2002:a05:6000:50:b0:48d:e696:8a65 with SMTP id ffacd0b85a97d-48e264db1a1mr8359382f8f.46.1792687341082;
        Thu, 22 Oct 2026 09:42:21 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2584c3b0sm15040175f8f.57.2026.10.22.09.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:42:20 -0700 (PDT)
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Casey Connolly <casey.connolly@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
	Joonhoe Kim <26rote@gmail.com>,
	Daniel J Blueman <daniel@quora.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladyslav Tymoshchuk <tvlad744@gmail.com>
Subject: [RFC PATCH 0/4] soc: qcom: pmic_glink: Hold back notifications over system sleep
Date: Thu, 22 Oct 2026 19:41:47 +0300
Message-ID: <20261022164151.592-1-tvlad744@gmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GLINK interrupt that delivers the PMIC GLINK messages is requested
with IRQF_NO_SUSPEND, so the clients get notifications during system
suspend and resume and in suspend-to-idle, and the work they schedule
for them can run while devices are suspended. Commit c7c56b6ec077
("soc: qcom: pmic_glink: Fix device access from worker during
suspend") moved the altmode worker to system_freezable_wq as a
stop-gap, and left the proper fix for later:

  The final shape of the rework of the pmic glink driver in order to
  fulfill both the filtering of the messages that need to be able to
  wake-up the system and the queueing of these messages until the
  system has properly resumed is still being discussed and it is
  planned as a future effort.

This series is a proposal for that shape, to have something concrete
to discuss:

- Patch 1 does the queueing: from ->prepare() on, pmic_glink holds the
  notifications back, and passes them on from system_freezable_wq once
  the system has resumed, in order, without duplicates, at most 64.
  Responses are passed on right away. The service UP is held back as
  well and passed on after the notifications, DOWN is passed on right
  away.

- Patch 2 does the filtering: a notification is a wakeup event if the
  client's device may wake up the system, see device_may_wakeup(), and
  the client's optional wakeup filter accepts it, which is the
  callback that Casey suggested [1]. pmic_glink reports the event when
  the notification arrives, and keeps the client's wakeup source
  active until the notification is delivered.

- Patch 3 enables wakeup for ucsi_glink, as Jishnu Prakash proposed
  [5], without the event in the callback.

- Patch 4 makes qcom_battmgr wakeup capable, with a filter for the
  charger notifications, but leaves wakeup disabled: Bjorn does not
  want a laptop to wake up in a backpack [9], and a battery charging
  state notification woke up Abel's laptop with some chargers [10].

The UCSI connector work running before the devices it uses have
resumed has been hit on three boards so far [3]: on X Elite with a
PS8830 retimer [2], on SM8850 with an FSA4480 switch, and on SM8750
with the dwc3-qcom role switch, where the register access with the
clocks off resets the SoC [4]. With patch 1, the clients don't have to
keep the work for their notifications off the system workqueue: Abel's
UCSI RFC [2] would not be needed, and the altmode stop-gap can stay or
go.

The earlier discussion is in the thread of the first version of the
altmode fix [1]. Krzysztof:

  Regardless whether we call pmic_glink a bus or some sort of
  transport mechanism, the users of its interface should not be
  called after they are suspended.

Bjorn asked whether a bus would mean "some mechanism for pmic_glink to
defer these messages until resume has happened". Abel found queueing
the messages fine, but noted that it does not decide when to wake up.
On the UCSI RFC, Dmitry asked to fix PMIC GLINK instead [2].

Why not in GLINK: dropping IRQF_NO_SUSPEND would break the other users
of the interrupt, as the description of c7c56b6ec077 says, and would
not close the race [6].

Why not a bus: patch 1 gives the guarantee Krzysztof asks for from the
pm callbacks of the pmic_glink device, and the wakeup policy stays
with the client devices, which reviewers preferred, according to [5],
over making the GLINK interrupt a wakeup interrupt [8]. cros_ec does
much the same: it passes the events that came during suspend on to its
clients in ->complete(), and decides whether an event wakes up the
system by its type and device_may_wakeup(). Its default wake mask
leaves out the battery events and the AC disconnect as "not actionable
wake events".

Open questions:

- ucsi_glink wakes the system up on a cable change by default, as in
  [5]. Should it only be wakeup capable, like qcom_battmgr?

- pmic_glink does not wait for the work that a client queues for a
  notification, so if a suspend starts right after a notification was
  passed on, the work can still overlap the suspend of devices. Should
  ucsi_glink cancel the UCSI work in its ->suspend() with
  ucsi_suspend(), like ucsi_acpi, or should a wakeup notification keep
  the system awake for a while, like the timeout in [5]?

- Only the latest of identical notifications is kept. That relies on
  the clients treating a notification as state, or as a hint to read
  the state, which holds for the in-tree ones. Should a client be able
  to opt out?

- qcom_battmgr notifications no longer reach power_supply_changed()
  during a suspend, so its wakeup source no longer aborts a suspend
  started through /sys/power/wakeup_count. Does anything rely on that?

- Patches 3 and 4 depend on the API added in patch 2. Should the whole
  series go through the Qualcomm SoC tree, with acks for those two?

Tested with suspend-to-idle on SM8750 (OnePlus Pad 3): the series on
top of the v7.3-rc5 based kernel that the device runs, with debug
prints added. That kernel does not have the dwc3-qcom fix [4].

- Awake, with qcom_battmgr wakeup enabled: of the 23 qcom_battmgr
  notifications for an unplug and replug, only the four USB property
  notifications were wakeup events.

- Cable plugged in (one run) or unplugged (two runs) during
  suspend-to-idle, with the default wakeup settings: the held-back UCSI
  notification woke the system up. 10 to 13 notifications were held
  back and 6 to 8 passed on after resume, none dropped. The wakeup
  source of ucsi_glink stayed active until they were passed on, about
  1.5 s. The UCSI work and the role switch ran only after that, and the
  SoC did not reset.

- With only qcom_battmgr wakeup enabled, a plug-in during
  suspend-to-idle woke the system up with the USB property
  notification. The UCSI notification before it was held back without
  a wakeup.

- With wakeup disabled for both clients, an unplug during
  suspend-to-idle did not wake the system up. The 11 notifications were
  held back until the RTC alarm 55 s later, and the SoC did not reset,
  so the queueing of patch 1 is enough to avoid the reset.

- 25 minutes of suspend-to-idle while charging: one qcom_battmgr
  notification came, was held back without a wakeup, and was passed on
  after resume, with the battery state updated right after.

Not tested: PDR during suspend, more than 64 notifications held back,
hibernation.

Kamal Wadhwa's PMIC GLINK RTC series [7] also changes pmic_glink.c, so
whichever goes in second needs a rebase. Its driver enables wakeup on
its device, so with patch 2 its notifications would become wakeup
events without further changes; today, the alarm only reports a soft
wakeup event through rtc_update_irq(), which does not end
suspend-to-idle.

I used an AI assistant (Claude) for the analysis and to draft these
patches and their descriptions; I reviewed the result and ran the
tests on my device.

[1] https://lore.kernel.org/all/20250110-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-v1-1-e32fd6bf322e@linaro.org/
[2] https://lore.kernel.org/all/20250205-ucsi-schedule-conn-worker-on-freezable-wq-v1-1-107d1356b77b@linaro.org/
[3] https://lore.kernel.org/all/20261020132432.998-1-26rote@gmail.com/
[4] https://lore.kernel.org/all/20261018143126.3978-1-tvlad744@gmail.com/
[5] https://lore.kernel.org/all/20260722-ucsi_glink_wakeup-v2-1-b43dee56df24@oss.qualcomm.com/
[6] https://lore.kernel.org/all/CAMVG2ssS4=Kb=OxuVXb_062fgvBfKz+X0q1N2rFob0TH6JypYg@mail.gmail.com/
[7] https://lore.kernel.org/all/20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com/
[8] https://lore.kernel.org/all/20240603073648.3475123-1-quic_deesin@quicinc.com/
[9] https://lore.kernel.org/all/ZnIe2hjPgWipDfgG@hu-bjorande-lv.qualcomm.com/
[10] https://lore.kernel.org/all/Z5taRZ0om5y%2FDJ69@linaro.org/

Vladyslav Tymoshchuk (4):
  soc: qcom: pmic_glink: Hold back notifications over system sleep
  soc: qcom: pmic_glink: Report wakeup events on behalf of clients
  usb: typec: ucsi: glink: Wake up the system on connector changes
  power: supply: qcom_battmgr: Allow charger changes to wake up the
    system

 drivers/power/supply/qcom_battmgr.c |  19 ++
 drivers/soc/qcom/pmic_glink.c       | 257 +++++++++++++++++++++++++++-
 drivers/usb/typec/ucsi/ucsi_glink.c |   6 +
 include/linux/soc/qcom/pmic_glink.h |   2 +
 4 files changed, 281 insertions(+), 3 deletions(-)


base-commit: 9a482184d910775cf648863148944945b74e2815
-- 
2.43.0

